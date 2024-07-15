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

- [пример ./incremental_build](./incremental_build/README.md)

# Продвинутые темы NixOS

## 1. Тестирование с виртуальной машиной

- [Пример: тест BitTorrent](https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/bittorrent.nix)
- [Пример: мульти-нодовый тест K3s](https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/k3s/multi-node.nix)

## 2. NixOS на спутнике

- [Видео: NixOS в космосе](https://www.youtube.com/watch?v=RL2xuhU9Nhk)

## 3. Изменение ядра системы

```nix
boot.kernelPackages = pkgs.linuxPackages_latest;
# boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
# boot.kernelPackages = pkgs.pkgs.linuxPackages_4_18;
```

## 4. Инструменты разработки

- devenv
- [Видео: devbox shell](https://www.youtube.com/watch?v=ZhwYh15a8Ls)

# Комплексное руководство по NixOS

## 1. NixOS vs Ansible
- **Ansible**: императивный подход (последовательность шагов)
- **NixOS**: декларативный подход ("манифест" желаемого состояния)

## 2. Кросс-компиляция
- [Урок по Кросс-компиляции](https://nix.dev/tutorials/cross-compilation)
- [Видео: Cross-Compile в NixOS](https://www.youtube.com/watch?v=OV2hi8b5t48)

```bash
nix repl '<nixpkgs>' -I nixpkgs=channel:nixos-23.11
nix-repl> pkgsCross.<TAB>
pkgsCross.aarch64-android             pkgsCross.musl-power
pkgsCross.aarch64-android-prebuilt    pkgsCross.musl32
pkgsCross.aarch64-darwin              pkgsCross.musl64
pkgsCross.aarch64-embedded            pkgsCross.muslpi
pkgsCross.aarch64-multiplatform       pkgsCross.or1k
pkgsCross.aarch64-multiplatform-musl  pkgsCross.pogoplug4
pkgsCross.aarch64be-embedded          pkgsCross.powernv
pkgsCross.amd64-netbsd                pkgsCross.ppc-embedded
pkgsCross.arm-embedded                pkgsCross.ppc64
pkgsCross.armhf-embedded              pkgsCross.ppc64-musl
pkgsCross.armv7a-android-prebuilt     pkgsCross.ppcle-embedded
pkgsCross.armv7l-hf-multiplatform     pkgsCross.raspberryPi
pkgsCross.avr                         pkgsCross.remarkable1
pkgsCross.ben-nanonote                pkgsCross.remarkable2
pkgsCross.fuloongminipc               pkgsCross.riscv32
pkgsCross.ghcjs                       pkgsCross.riscv32-embedded
pkgsCross.gnu32                       pkgsCross.riscv64
pkgsCross.gnu64                       pkgsCross.riscv64-embedded
pkgsCross.i686-embedded               pkgsCross.scaleway-c1
pkgsCross.iphone32                    pkgsCross.sheevaplug
pkgsCross.iphone32-simulator          pkgsCross.vc4
pkgsCross.iphone64                    pkgsCross.wasi32
pkgsCross.iphone64-simulator          pkgsCross.x86_64-embedded
pkgsCross.mingw32                     pkgsCross.x86_64-netbsd
pkgsCross.mingwW64                    pkgsCross.x86_64-netbsd-llvm
pkgsCross.mmix                        pkgsCross.x86_64-unknown-redox
pkgsCross.msp430
```

```bash
nix-build '<nixpkgs>' -I nixpkgs=channel:nixos-23.11 \
  --arg crossSystem '{ config = "aarch64-unknown-linux-gnu"; }' \
  -A hello
```

## 3. nix-init и Poetry
Примеры использования:
- [golang https://github.com/viktomas/godu](nix_init/golang/README.md)

- Для Python nix-init не сработал так хорошо, поэтому без него
- [jupyenv](nix_init/python/jupyenv/README.md)
 - Для python `kernel.python.minimal.enable = true`
 - Для Go     `kernel.go.minimal-example.enable  = true`
 - Для C      `kernel.c.minimal-example.enable  = true`
 - И для других ...
- [python-poetry](nix_init/python/python-poetry-tutorial/README.md)
- [proxy sshuttle](nix_init/python/sshuttle/README.md)

## 4. NixOS vs Docker
- Docker не перестраивает слой, если не знает об изменениях
- [Пример динамической генерации Docker образов с Nix](https://youtu.be/pfIDYQ36X0k?list=PLzK3KxVQUZEXEq820lpONsP9QFXYK8jkx&t=990)
- [Nixery: динамическая генерация Docker образов](https://nixery.dev/)
- [NixOS Dockertools](https://ryantm.github.io/nixpkgs/builders/images/dockertools/)

## 5. Чистота системы
- Выход из shell удаляет пакеты

## 6. Управление конфигурациями
- Nix позволяет декларативно описывать различные варианты запуска сервисов
- Унификация конфигураций различных сервисов через Nix

## 7. Масштабируемость настроек
- Настройка одного экземпляра позволяет легко масштабировать на остальные

## 8. Кто использует Nix
- [Anduril Industries](https://github.com/anduril/jetpack-nixos)
- [Shopify](https://shopify.engineering/what-is-nix)
- [Copier](https://github.com/copier-org/copier)
- и многие другие...

## 9. Docker и Nix
- [Видео: Docker и Nix](https://www.youtube.com/watch?v=l17oRkhgqHE)
- [Docker Babashka Pod](https://github.com/docker/babashka-pod-docker)
- [Почему Alpine используется в Docker](https://youtu.be/pfIDYQ36X0k?list=PLzK3KxVQUZEXEq820lpONsP9QFXYK8jkx&t=2206)

## 10. Преимущества NixOS
- [Сравнение с Arch Linux](https://youtu.be/0uixRE8xlbY?t=1017)

## 11. Полезные ссылки
- [Поиск пакетов NixOS](https://search.nixos.org/packages)
- [NixHub: поиск Go пакетов](https://www.nixhub.io/packages/go)
- [Опции Home Manager](https://home-manager-options.extranix.com/)

## 12. Как изучать Nix
- [Официальные туториалы](https://nix.dev/tutorials/index.html)
- [NixOS и Flakes](https://nixos-and-flakes.thiscute.world/introduction/)
- [Flake Parts Community](https://community.flake.parts/services-flake)
- GitHub поиск: "language:nix myoption"
- [Репозиторий NixOS/nixpkgs](https://github.com/NixOS/nixpkgs)
- [Руководство Nixpkgs](https://nixos.org/manual/nixpkgs/stable/)
