# Outline

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

## Шаг 3 - Установа [Outline Manager](https://getoutline.org/ru/get-started/#step-1)

После загрузки и установки предлагается создать аккаунт в облачном сервисе, но это нам не требуется. Выбираем опцию «Настроить Outline где угодно». Появляются два поля. Из первого поля «Зайдите на сервер и выполните эту команду» копируем команду и выполняем на сервере. Второе поле «Вставить сюда информацию, полученную при выполнении скрипта установки» нужно заполнить на основе вывода, который вы увидите после успешного выполнения команды. Пример содержимого указан, запутаться сложно.

## Шаг 4 — Установка [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru)

Пакет установки Docker, доступный в официальном репозитории Ubuntu, может содержать не самую последнюю версию. Чтобы точно использовать самую актуальную версию, мы будем устанавливать Docker из официального репозитория Docker. Для этого мы добавим новый источник пакета, ключ GPG от Docker, чтобы гарантировать загрузку рабочих файлов, а затем установим пакет.

Первым делом обновите существующий список пакетов:

```bash
sudo apt update
```

Затем установите несколько необходимых пакетов, которые позволяют apt использовать пакеты через HTTPS:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

Добавьте ключ GPG для официального репозитория Docker в вашу систему:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Добавьте репозиторий Docker в источники APT:

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```

Потом обновите базу данных пакетов и добавьте в нее пакеты Docker из недавно добавленного репозитория:

```bash
sudo apt update
```

Убедитесь, что установка будет выполняться из репозитория Docker, а не из репозитория Ubuntu по умолчанию:

```bash
apt-cache policy docker-ce
```

Вы должны получить следующий вывод, хотя номер версии Docker может отличаться:

```bash
docker-ce:
  Installed: (none)
  Candidate: 5:19.03.9~3-0~ubuntu-focal
  Version table:
     5:19.03.9~3-0~ubuntu-focal 500
        500 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
```

Обратите внимание, что `docker-ce` не установлен, но является кандидатом на установку из репозитория Docker для Ubuntu 20.04 (версия `focal`).

Установите Docker:

```bash
sudo apt install docker-ce
```

### Дополнительно

Проверьте, что он запущен:

```bash
sudo systemctl status docker
```

Вывод должен выглядеть примерно следующим образом, указывая, что служба активна и запущена:

```bash
Output
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-05-19 17:00:41 UTC; 17s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 24321 (dockerd)
      Tasks: 8
     Memory: 46.4M
     CGroup: /system.slice/docker.service
             └─24321 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

После установки Docker у вас будет доступ не только к службе Docker (демон-процесс), но и к утилите командной строки docker или клиенту Docker.

## Шаг 5 - выполнить остатки Шага 2

## Завершение

Для завершения сессии используйте:Выход

```bash
logout
```

или

```bash
exit
```