#!/bin/bash

LOG_FILE="access.log"
REPORT_FILE="report.txt"

# 1. Общее количество запросов
echo "Общее количество запросов:" >> "$REPORT_FILE"
echo "=========================" >> "$REPORT_FILE"
wc -l < "$LOG_FILE" >> "$REPORT_FILE"

# 2. Уникальные IP-адреса
echo -e "\nУникальные IP-адреса:" >> "$REPORT_FILE"
awk '{print $1}' "$LOG_FILE" | sort -u | wc -l >> "$REPORT_FILE"

# 3. Количество запросов по методам
echo -e "\nКоличество запросов по методам:" >> "$REPORT_FILE"
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -nr >> "$REPORT_FILE"

# 4. Самый популярный URL
echo -e "\nСамый популярный URL:" >> "$REPORT_FILE"
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1 >> "$REPORT_FILE"

echo "Отчёт сформирован в файле: $REPORT_FILE"
