# Yet Another PostgreSQL для 1С

образа для развертывания контуров PostgreSQL для 1С - состоит непосредственно из собранных образов опубликованных по адресу https://hub.docker.com/r/silverbulleters/ya-docker-postgresql-1c и утилит настройки и сборки

* базируется на сборках PostgeSQL.Pro http://repo.postgrespro.ru
* последняя версия PostgeSQL.Pro `12.2`

## Сборщик контуров с PostgreSQL

* актуальная версия: 1.0.1.1
* собираемые версии: 10.10,10.11,10.12,10.4,10.5,10.6,10.7,11.1,11.2,11.5,11.6,11.7,12.1,12.2

## Где смотреть особенности

* https://www.postgresql.org/docs/release/

## Что читать

* https://postgrespro.ru/docs/postgresql/

### Список исключаемаых сборок

#### Ubuntu

* 11.1 - баг cubedata.h по ошибке попал в 2 пакета - server и dev - фактически самам сборка нестабильна, собственно исправление выпущено уже в релизе 11.2
