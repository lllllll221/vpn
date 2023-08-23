# Shadowsocks

## Шаг 1

Первое, что необходимо сделать, — это завести VPS сервер.

![SHUT-UP-AND-TAKE-MY-MONEY](https://github.com/lllllll221/vpn/blob/master/misc/SHUT-UP-AND-TAKE-MY-MONEY.png)

После оплаты сервера на почту приходят все данные для подключения, такие как: имя пользователя, пароль и IP-адрес. Таким образом, можно подключиться прямо из родного терминала с помощью SSH: `ssh 'user_name'@'ip_adress'` и ввести пароль. Если есть желание, можно скачать дополнительную программу и подключаться через неё.

## Шаг 2 - Обновление

```bash
    sudo apt update
```

```bash
    sudo apt upgrade
```

или

```bash
    sudo apt update && sudo apt upgrade
```

## Шаг 3 - [Установа/настрйока/запуск/автозапуск Shadowsocks](https://github.com/lllllll221/vpn/blob/master/shadowsocks/setup.sh)

### Непосредственно сама установка

```bash
    sudo apt update
```
```bash
    sudo apt install python3-pip
```
```bash
    pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip
```
### Теперь самое прикольное настройка

Создайте файл конфигурации, например, `ss-config.json`:

```bash
    nano ss-config.json
```

Вставьте следующее:

```json
    {
        "server":"0.0.0.0",
        "server_port":8388,
        "local_address":"127.0.0.1",
        "local_port":1080,
        "password":"YOUR_PASSWORD",
        "timeout":300,
        "method":"chacha20-ietf-poly1305"
    }
```

Вместо `YOUR_PASSWORD` укажите желаемый пароль для соединения. Вы также можете изменить порт, адрес и метод шифрования по вашему усмотрению.

### Запуск Shadowsocks

```bash
    ssserver -c ss-config.json -d start
```

+    `-c ss-config.json` указывает путь к файлу конфигурации.
+    `-d start` указывает на запуск сервера в режиме демона.

### Автозапуск Shadowsocks при перезагрузке

Чтобы Shadowsocks автоматически запускался при перезагрузке сервера, добавьте команду запуска в crontab:

```bash
    (crontab -l; echo "@reboot ssserver -c /path/to/ss-config.json -d start") | crontab -
```

Замените `/path/to/ss-config.json` на абсолютный путь к вашему файлу конфигурации.

## Шаг 4 - Подключение

Установите клиент Shadowsocks на своем устройстве, используйте данные из файла конфигурации для соединения и убедитесь, что все работает корректно.

## Шаг 5 - Получение URL для подключения

Для получения ссылки в формате `ss://` из файла конфигурации `ss-config.json`, нужно прочитать этот файл, извлечь необходимые параметры и сформировать ссылку. Это можно сделать с помощью небольшого bash-скрипта с использованием утилит `jq` (для обработки JSON) и `base64`

Убедитесь, что у вас установлен `jq`. Если нет, установите его:

```bash
    sudo apt-get install jq
```

Используйте следующую команду bash для получения ссылки `ss://`:

```bash
    CONFIG_FILE="ss-config.json" && METHOD=$(jq -r .method "$CONFIG_FILE") && PASSWORD=$(jq -r .password "$CONFIG_FILE") && SERVER=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') && PORT=$(jq -r .server_port "$CONFIG_FILE") && SS_URL="ss://$(echo -n "$METHOD:$PASSWORD" | base64)@$SERVER:$PORT" && echo "$SS_URL"
```

Либо воспользоваться [этим](https://github.com/lllllll221/vpn/blob/master/outline/extract_url.sh).

## Завершение

Для завершения сессии используйте:Выход

```bash
    logout
```

или

```bash
    exit
```