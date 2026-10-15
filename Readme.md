## Генерация SSH-ключа на Source Server (Откуда копируем)
```
sudo su - lsyncd-test
ssh-keygen -t ed25519 -C "lsyncd-sync"
# Нажмите Enter для всех вопросов (используем путь по умолчанию ~/.ssh/id_ed25519)
```

## Копирование публичного ключа на Destination Server (Куда копируем)
```
ssh-copy-id -i ~/.ssh/id_ed25519.pub lsyncd-test@<DESTINATION_IP>
```

## Установка Lsyncd

```
sudo apt update
sudo apt install lsyncd
```

## Конфигурация Lsyncd
```
sudo nano /etc/lsyncd.conf
```

## Создание директории для логов
```
sudo mkdir -p /var/log/lsyncd
sudo chown lsyncd-test:lsyncd-test /var/log/lsyncd
```

## Настройка systemd сервиса
```
sudo systemctl edit lsyncd
```

```
[Service]
User=lsyncd-test
Group=lsyncd-test
Environment="HOME=/home/lsyncd-test"
```

## Запуск и тестирование

```
sudo systemctl daemon-reload
sudo systemctl enable lsyncd
sudo systemctl start lsyncd
```

## Проверка статуса

```
sudo systemctl status lsyncd
```

## Просмотр логов

```
tail -f /var/log/lsyncd/lsyncd.log
```