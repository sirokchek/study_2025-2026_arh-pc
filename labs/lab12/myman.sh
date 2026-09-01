#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Использование: $0 <команда>"
    echo "Пример: $0 ls"
    exit 1
fi

CMD="$1"
MAN_FILE="/usr/share/man/man1/${CMD}.1.gz"

if [ -f "$MAN_FILE" ]; then
    echo "Справка для команды $CMD:"
    zcat "$MAN_FILE" | less
else
    echo "Справка для команды $CMD не найдена"
fi
