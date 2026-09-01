#!/bin/bash

# Механизм семафоров
# Использование: ./semaphore.sh <имя_семафора> <время_ожидания> <время_использования>

if [ $# -ne 3 ]; then
    echo "Использование: $0 <имя_семафора> <время_ожидания> <время_использования>"
    exit 1
fi

SEMAPHORE="$1"
WAIT_TIME="$2"
USE_TIME="$3"
SEM_FILE="/tmp/sem_${SEMAPHORE}"

create_semaphore() {
    if [ ! -f "$SEM_FILE" ]; then
        echo "$$" > "$SEM_FILE"
        return 0
    fi
    return 1
}

remove_semaphore() {
    if [ -f "$SEM_FILE" ] && [ "$(cat "$SEM_FILE")" = "$$" ]; then
        rm -f "$SEM_FILE"
        return 0
    fi
    return 1
}

echo "Процесс $$ пытается захватить семафор '$SEMAPHORE'"

while true; do
    if create_semaphore; then
        echo "Процесс $$ захватил семафор '$SEMAPHORE' на $USE_TIME сек."
        sleep "$USE_TIME"
        remove_semaphore
        echo "Процесс $$ освободил семафор '$SEMAPHORE'"
        break
    else
        echo "Процесс $$ ждёт освобождения семафора..."
        sleep 2
    fi
done
