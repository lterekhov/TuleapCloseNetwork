# Установка tuleap в закрытой сети с использованием docker

Для установки tuleap в закрытой сети с использованием докер, необходимо подготовить все зависимости, а также docker images.



Детали могут отличаться, но суть одна.

## Схема

Общая идея продемонстрирована на схеме ниже.

![](scheme/tuleap_close_network.png)

Дальше берем nexus и docker-tuleap и переносим куда нужно уже без интернета.

 

## Менеджер репозиториев

Необходим для кэширования зависимостей. 

https://www.sonatype.com/nexus-repository-oss

https://help.sonatype.com/repomanager3/installation/installation-methods

Качаем архив и запускаем. `nexus.exe /run`

http://localhost:8081/

Пароль от администратора в файле `admin.password` внутри `$data-dir`:

https://help.sonatype.com/repomanager3/installation/accessing-the-user-interface

### Настройка 

* Создаем blobstores: **yum**
* Создаем proxy yum repository (`Repositories > Create repository > yum (proxy)`):
  * **Tuleap**
    * <u>name</u>: RSSTuleap
    * <u>remote storage</u>: https://ci.tuleap.net/yum/tuleap/rhel/6/dev/
    * <u>blob store</u>: yum
  * **Centos**
    * <u>name</u>: centos
    * <u>remote storage</u>: http://mirror.centos.org/centos/
    * <u>blob store</u>: yum
  * **Epel-Tuleap**
    * <u>name</u>: epel-tuleap
    * <u>remote storage</u>: http://mirror.linux-ia64.org/epel/6/
    * <u>blob store</u>: yum
  * **Remirepo**
    * <u>name</u>: remirepo
    * <u>remote storage</u>: http://rpms.remirepo.net/enterprise/6/safe/
    * <u>blob store</u>: yum

## Docker

За основу сборки взять официальный репозиторий tuleap для docker:

https://github.com/Enalean/docker-tuleap-aio

Правим файл Dockerfile заменяя все конфиги репозиториев в `/etc/yum.repos.d/`

Чтобы понять какие файлы находятся в данной папке можно добавить `RUN ls /etc/yum.repos.d` в Dockerfile, что выведет список всех файлов с конфигурацией.

***Все файлы должны быть заменены!***

### Конфиги репозиториев

#### tuleap

https://github.com/Enalean/docker-tuleap-aio

Настраиваем Tuleap и remi.

![](images/tuleap-repos.png)

#### centos

https://github.com/CentOS/sig-cloud-instance-images/tree/23b05f6a35520ebf338e4df918e4952830da068b/docker

Качаем архив, распаковываем и идем смотреть, какие репы нужно перенести

![](images/centos-repos.png)

Настраиваем CentOS-Base. Остальные делаем пустыми.

#### **centos-release-scl**

https://github.com/sclorg/centos-release-scl/tree/master/centos-release-scl

Прилетает при установке [centos-release-scl](https://github.com/Enalean/docker-tuleap-aio/blob/master/Dockerfile#L11)

Настраиваем `CentOS-SCLo.repo`

С помощью `RUN ls /etc/yum.repos.d`  узнал, что прилетают так-же `CentOS-SCLo-scl.repo` и `CentOS-SCLo-scl-rh.repo`. Создаем пустые файлики.

#### epel-release

https://github.com/dayne/yum/blob/master/centos6/epel.repo

Настраиваем `epel.repo`

Создаем пустой `epel-testing.repo`

### Перенос images

Для сборки конечного изображения понадобятся два images:

* centos (tag 6)
* mysql (tag 5.6)

#### save

```bash
$> docker save centos > centos.tar
$> docker save mysql > mysql.tar
```

#### load 

```bash
$> docker load -i centos.tar
$> docker load -i mysql.tar
```



## Запуск сборки

Для сборки используем docker-compose

Запуск

```bash
$> docker-compose up
```

