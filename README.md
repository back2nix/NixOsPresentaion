# NixOS: История и Особенности

---

## Хронология

- **NixOS:** Основан 3 июня 2003 года
- **Ubuntu:** Появился 20 октября 2004 года

---

## Масштаб

- **NixOS:** Более 100,000 пакетов
- **Ubuntu:** 84,532 пакета
  ```
  apt-cache pkgnames | sort -u | wc -l
  ```

---

## Активность сообщества

- Ежемесячно поступает около 1300 Merge Request

---

## Безопасность

- Повышенная защита от уязвимостей
- [Подробнее о безопасности](https://youtu.be/pfIDYQ36X0k?list=PLzK3KxVQUZEXEq820lpONsP9QFXYK8jkx&t=281)

---

## Изоляция сборки

- В отличие от NPM или Ruby, NixOS предотвращает отправку кода на сторонние серверы во время сборки
- Фаза сборки отделена от скачивания
- Во время сборки нет доступа в интернет

---

## Интеллектуальная система сборки

- Не требуется принудительная пересборка так как,
- Nix имеет полное представление о всех входных файлах для сборки

---

## Многофункциональность

Nix можно рассматривать как:
- Менеджер пакетов
- Инструмент для сборки

# Руководство по упаковке в NixOS

## 1. Обертывание пакетов

- Пример того, как обернуть пакет, не требуя дополнительной установки зависимостей:
  - [Пример: проект Speaker](https://github.com/back2nix/speaker)

## 2. Подготовка пакетов Python

- Руководство по созданию пакетов для Python:
  - [Документация NixOS по Python](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md)

### Полезные команды:

- [Пример на python sshuttle "Transparent proxy"](https://github.com/sshuttle/sshuttle)

```bash
nix run github:sshuttle/sshuttle --dns -r ssh@server 0/0
nix run . --dns -r ssh@server 0/0
nix develop
nix flake show
```

## 3. Проекты Golang

- Руководство по работе с Golang проектами:
  - [Документация NixOS по Go](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/go.section.md)

### Инициализация проекта:

```nix
nix flake init -t github:nix-community/gomod2nix#app
```

### Разработка и сборка:

```bash
nix develop
nix build
```

### 3. Incremental Build

- [./incremental_build](./incremental_build/README.md)

### 4. Тестирование с виртуальной машиной

- https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/bittorrent.nix
- https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/k3s/multi-node.nix

### 5. NixOs на спутнике

- https://www.youtube.com/watch?v=RL2xuhU9Nhk

### 6. Поменять ядро

```
boot.kernelPackages = pkgs.linuxPackages_latest;
#boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
#boot.kernelPackages = pkgs.pkgs.linuxPackages_4_18;
```

### 7. devbox shell

- devenv
- https://www.youtube.com/watch?v=ZhwYh15a8Ls

### 7. NixOS vs Ansible

```
Главное философское различие между NixOS и Ansible заключается в подходах к программированию: императивном и декларативном. Ansible playbooks представляют собой последовательность шагов, выполняемых для достижения желаемого конечного состояния.
Конфигурации NixOS, напротив, являются "манифестом" желаемого конечного состояния.
```

### 7. Cross-Compile

- https://www.youtube.com/watch?v=OV2hi8b5t48

### 8 nix-init poetry

- golang
- python/python-poetry-tutorial
- python/sshuttle

### 9. NixOS vs Docker

- Docker не будет перестраивать слой. Потому что он не знает изменилось ли там что-то
- https://youtu.be/pfIDYQ36X0k?list=PLzK3KxVQUZEXEq820lpONsP9QFXYK8jkx&t=990
- динамически генерит образ докер с помощью nix
- https://nixery.dev/
- https://ryantm.github.io/nixpkgs/builders/images/dockertools/

### 10. Не загрязняем систему

- Вышел из shell и нет пакета

### 10. Различные варианты запуска зоопарка сервисов записаны в README.md?

- Nix позволяет задекларировать эти варианты и переключатся на них с помощью флагов
- Не нужно больше читать документацию по разным сервисам. Все конфиги будут однотипными через nix

### 11. Настроил один остальные просто используют

### 12. Кто использует nix

- https://github.com/anduril/jetpack-nixos
- https://shopify.engineering/what-is-nix
- https://github.com/copier-org/copier
- and more...


### 13. Youtube

- docker and nix
- https://www.youtube.com/watch?v=l17oRkhgqHE
- https://github.com/docker/babashka-pod-docker
- Почему alpline используют в докере ?
- https://youtu.be/pfIDYQ36X0k?list=PLzK3KxVQUZEXEq820lpONsP9QFXYK8jkx&t=2206

### 15. Лучше чем у Arch больше чем у Arch и более воспроизводимее чем у дригих дистро

- https://youtu.be/0uixRE8xlbY?t=1017

### 15. Ссылки

- https://search.nixos.org/packages
- https://www.nixhub.io/packages/go
- https://home-manager-options.extranix.com/

### Как изучать nix?

- https://nix.dev/tutorials/index.html
- https://nixos-and-flakes.thiscute.world/introduction/
- https://community.flake.parts/services-flake
- github поиск: "language:nix myoption"
- https://github.com/NixOS/nixpkgs
- https://nixos.org/manual/nixpkgs/stable/
