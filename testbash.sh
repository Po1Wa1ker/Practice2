#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
  echo "Error: need an argument for INFODIR."
  exit 1
fi

INFODIR=$1
PROC="procinfo"
DISK="diskinfo"
SMART="smartinfo"
RAM="raminfo"
NET="networkinfo"

# 1. Создать директорию pw2 в /storage.
mkdir -p /mnt/storage/pw2

# 2. Создать файл file1 и записать в него Hello World.
echo "Hello World" > /storage/pw2/file1

# 3. Создать файл file2 и записать в него текущую дату и время.
date > /mnt/storage/pw2/file2

# 4. Добавить строку своим именем в файл file1.
echo "Oleg" >> /mnt/storage/pw2/file1

# 5. Добавить 3 строки Linux is awesome в файл file2.
for i in {1..3}; do echo "Linux is awesome" >> /mnt/storage/pw2/file2; done

# 6. Скопировать содержимое файла file1 в файл file2 (не перезаписывая его).
cat /mnt/storage/pw2/file1 >> /mnt/storage/pw2/file2

# 7. Создать файл file3 и добавить в него содержимое файлов file1 и file2.
cat /mnt/storage/pw2/file1 /mnt/storage/pw2/file2 > /mnt/storage/pw2/file3

# 8. Переименовать файл file1 в newfile1.
mv /mnt/storage/pw2/file1 /mnt/storage/pw2/newfile1

# 9. Перенаправить вывод команды ls в файл file4 3 раза.
for i in {1..3}; do ls >> /mnt/storage/pw2/file4; done

# 10. Отобразить содержимое файла file4 и сохранить его в файл file5.
cat /mnt/storage/pw2/file4 > /mnt/storage/pw2/file5

# 11. Вывести количество строк в файле file5.
wc -l < /mnt/storage/pw2/file5

# 12. Создать пустую директорию dir1.
mkdir /mnt/storage/pw2/dir1

# 13. Переместить файл file5 в директорию dir1.
mv /mnt/storage/pw2/file5 /mnt/storage/pw2/dir1

# 14. Создать символическую ссылку на файл file4 в текущей директории.
ln -s /mnt/storage/pw2/file4 ./file4_link

# 15. Скопировать содержимое директории dir1 в директорию dir2.
mkdir /mnt/storage/pw2/dir2
cp -r /mnt/storage/pw2/dir1/* /mnt/storage/pw2/dir2/

# 16. Показать только имена файлов в текущей директории.
ls -1

# 17. Перезаписать файл file5 пустым содержимым.
> /mnt/storage/pw2/dir1/file5

# 18. Вывести на экран информацию о системе и ядре и сохранить ее в файл file6.
uname -a > /mnt/storage/pw2/file6

# 19. Создать новую директорию с именем mydir.
mkdir /mnt/storage/pw2/mydir

# 20. Создать пустой файл с именем file7 в директории mydir.
touch /mnt/storage/pw2/mydir/file7

# 21. Удалить директорию mydir и все ее содержимое.
rm -r /mnt/storage/pw2/mydir

# 22. Вывести только последние 2 строки файла file2.
tail -n 2 /mnt/storage/pw2/file2

# 23. Добавить переменные.
# (Сделано ранее в начале скрипта)

# 24. Создать директорию $INFODIR.
mkdir -p "$INFODIR"

# 25. Вывести список всех процессов, запущенных в системе и сохранить ее в файл $INFODIR/$PROC.
ps aux > "$INFODIR/$PROC"

# 26. Вывести информацию о дисках и сохранить в файл $INFODIR/$DISK.
lsblk > "$INFODIR/$DISK"

# 27. Вывести информация о системном диске и сохранить ее в файл $INFODIR/$SMART.
if [ -e /dev/sda ]; then
  smartctl -a /dev/sda > "$INFODIR/$SMART"
else
  blkid | grep -i 'UUID' > "$INFODIR/$SMART"
fi

# 28. Вывести информацию об оперативной памяти и сохранить ее в файл $INFODIR/$RAM.
free -h > "$INFODIR/$RAM"

# 29. Вывести информацию о сети и сохранить ее в файл $INFODIR/$NET.
ip addr show > "$INFODIR/$NET"
