#!/bin/bash

# Проверка на количество точек в формате
[[ "$(echo "$1" | tr -cd "." | wc -m)" -ne 1 ]] && echo "Неверный формат списка символов файлов" && exit 1

for (( i = 0; i < ${#1}; i++ ))
do
    if [[ "${1: i: 1}" == "." ]]; then
        # Проверка на количество символов по обе стороны точки
        [[ "$i" -gt 7 || "$i" -eq 0 ]] && echo "Символов для названия файлов не может быть больше 7 или меньше 1" && exit 1
        [[ "${#1} - $i" -gt 4 || "${#1} - $i" -le 1 ]] && echo "Символов для расширения файлов не может быть больше 3 или меньше 1" && exit 1

        # Проверка на уникальность символов в формате файлов
        for (( j = 0; j < i - 1; j++ ))
        do
            [[ "${1: j + 1: i - j}" =~ "${1: j: 1}" ]] && echo "Список символов файлов не может содержать одинаковые символы" && exit 1
        done
    else
        # Проверка на пренадлежность символов папок латинице
        [[ ! ${1: i: 1} =~ ^[a-z]+$ && ! ${1: i: 1} =~ ^[A-Z]+$ ]] && echo "Список символов папок должны пренадлежать латинице" && exit 1
    fi
done