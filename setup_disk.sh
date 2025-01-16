#!/bin/bash

# Проверяем, что скрипт запущен с правами суперпользователя
if [ "$EUID" -ne 0 ]; then
  echo "Need admin rights (root)." 
  exit 1
fi

# Параметры по скрипта
FILESYSTEM_TYPE="ext4"
MOUNT_POINT="/storage"
DEVICE="/dev/sdb"

# Создание файловой системы (дополнительное задание)
if [ "$FILESYSTEM_TYPE" == "ext2" ]; then
  mkfs.ext2 "$DEVICE"
elif [ "$FILESYSTEM_TYPE" == "ext3" ]; then
  mkfs.ext3 "$DEVICE"
elif [ "$FILESYSTEM_TYPE" == "ext4" ]; then
  mkfs.ext4 "$DEVICE"
elif [ "$FILESYSTEM_TYPE" == "xfs" ]; then
  mkfs.xfs "$DEVICE"
else
  echo "Error system type: $FILESYSTEM_TYPE"
  exit 1
fi

# Создание точки монтирования, если не существует
mkdir -p "$MOUNT_POINT"

# Получение PARTUUID
UUID=$(blkid -o export "$DEVICE" | grep UUID)

# Добавление записи в /etc/fstab
echo "$UUID $MOUNT_POINT $FILESYSTEM_TYPE defaults 0 0" >> /etc/fstab

# Монтирование файловой системы
mount "$MOUNT_POINT"

echo "Script ended."
