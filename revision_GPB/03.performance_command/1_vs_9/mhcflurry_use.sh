#!/bin/bash
################################################################
# 准确的资源监控脚本 - 统计进程树中所有子进程
################################################################

set -u

COMMAND_SCRIPT="/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command/1_vs_9/mhcflurry_command.sh"
OUTPUT_LOG="/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command/1_vs_9/mhcflurry_use.log"
RESOURCE_LOG="/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command/1_vs_9/mhcflurry_resource.log"
MONITOR_LOG="/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command/1_vs_9/mhcflurry_monitor.log"

# 初始化日志
echo "========================================" > "$RESOURCE_LOG"
echo "Job: $(basename $COMMAND_SCRIPT .sh)" >> "$RESOURCE_LOG"
echo "Started at: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RESOURCE_LOG"
echo "Host: $(hostname)" >> "$RESOURCE_LOG"
echo "========================================" >> "$RESOURCE_LOG"

# 记录起始时间
START_TIME=$(date +%s)

# 启动任务（后台）
# taskset -c 0-9 bash "$COMMAND_SCRIPT" > "$OUTPUT_LOG" 2>&1 &
# 不使用 taskset，让系统自动调度到所有可用CPU核心
# 这样可以避免多个任务绑定到相同核心上造成的性能干扰
bash "$COMMAND_SCRIPT" > "$OUTPUT_LOG" 2>&1 &
MAIN_PID=$!

echo "Main PID: $MAIN_PID" >> "$RESOURCE_LOG"
echo "" >> "$RESOURCE_LOG"

# 初始化峰值统计
MAX_CPU=0
MAX_MEM=0
MAX_RSS=0

# 监控日志头部
echo "Time(s),Total_CPU(%),Total_MEM(%),Total_RSS(KB),Process_Count" > "$MONITOR_LOG"

# 持续监控进程树
ELAPSED=0
while kill -0 $MAIN_PID 2>/dev/null; do
    # 获取进程树中所有PID（包括所有子孙进程）
    PIDS=$(pstree -p $MAIN_PID 2>/dev/null | grep -o '([0-9]\+)' | grep -o '[0-9]\+' | tr '\n' ',' | sed 's/,$//')
    
    if [ -n "$PIDS" ]; then
        # 统计所有进程的资源总和
        STATS=$(ps -p "$PIDS" -o %cpu,%mem,rss --no-headers 2>/dev/null | \
                awk -v max_cpu=$MAX_CPU -v max_mem=$MAX_MEM -v max_rss=$MAX_RSS '
                {
                    total_cpu += $1
                    total_mem += $2
                    total_rss += $3
                    count++
                }
                END {
                    if (total_cpu > max_cpu) max_cpu = total_cpu
                    if (total_mem > max_mem) max_mem = total_mem
                    if (total_rss > max_rss) max_rss = total_rss
                    printf "%.2f,%.2f,%d,%d,%.2f,%.2f,%d\n", 
                           total_cpu, total_mem, total_rss, count, max_cpu, max_mem, max_rss
                }')
        
        # 解析统计结果
        IFS=',' read -r CPU MEM RSS COUNT NEW_MAX_CPU NEW_MAX_MEM NEW_MAX_RSS <<< "$STATS"
        
        # 更新峰值
        MAX_CPU=$(awk -v a=$MAX_CPU -v b=$NEW_MAX_CPU 'BEGIN{print (a>b)?a:b}')
        MAX_MEM=$(awk -v a=$MAX_MEM -v b=$NEW_MAX_MEM 'BEGIN{print (a>b)?a:b}')
        MAX_RSS=$(awk -v a=$MAX_RSS -v b=$NEW_MAX_RSS 'BEGIN{print (a>b)?a:b}')
        
        # 记录实时数据
        echo "$ELAPSED,$CPU,$MEM,$RSS,$COUNT" >> "$MONITOR_LOG"
    fi
    
    sleep 2  # 每2秒采样一次
    ELAPSED=$((ELAPSED + 2))
done

# 等待主进程完全结束
wait $MAIN_PID
EXIT_CODE=$?

# 计算总耗时
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# 转换时间格式
HOURS=$((TOTAL_TIME / 3600))
MINUTES=$(((TOTAL_TIME % 3600) / 60))
SECONDS=$((TOTAL_TIME % 60))

# 输出最终统计
echo "========================================" >> "$RESOURCE_LOG"
echo "RESOURCE USAGE SUMMARY" >> "$RESOURCE_LOG"
echo "========================================" >> "$RESOURCE_LOG"
echo "Peak CPU usage: ${MAX_CPU}%" >> "$RESOURCE_LOG"
echo "Peak Memory usage: ${MAX_MEM}%" >> "$RESOURCE_LOG"
echo "Peak RSS (Memory): ${MAX_RSS} KB ($(awk "BEGIN {printf \"%.2f\", $MAX_RSS/1024}") MB)" >> "$RESOURCE_LOG"
echo "Total wall time: ${HOURS}h ${MINUTES}m ${SECONDS}s" >> "$RESOURCE_LOG"
echo "Exit code: $EXIT_CODE" >> "$RESOURCE_LOG"
echo "========================================" >> "$RESOURCE_LOG"
echo "Finished at: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RESOURCE_LOG"
echo "========================================" >> "$RESOURCE_LOG"

# 输出到终端
echo "Execution completed."
echo "Output log: $OUTPUT_LOG"
echo "Resource summary: $RESOURCE_LOG"
echo "Detailed monitoring: $MONITOR_LOG"
echo "Peak Memory: $(awk "BEGIN {printf \"%.2f MB\", $MAX_RSS/1024}")"
echo "Total time: ${HOURS}h ${MINUTES}m ${SECONDS}s"

if [ $EXIT_CODE -ne 0 ]; then
    echo "WARNING: Command failed with exit code $EXIT_CODE"
fi

exit $EXIT_CODE
