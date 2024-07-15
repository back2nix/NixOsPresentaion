# Incremental build package in nix

Это нужно для упрощения разработки.

- Экономить время на сборке debug проекта и проще отлаживать
- Разработчику больше не нужно парится про развертывание проекта
- Дебажить проект стало намного проще, не нужно в другом проекте изменять сборку чтобы внедрить дебажную либу так как подменяется системаня либа
- Это позволяет сэкономить время + не дебажить принтами в коде из за того что не каждый разраб разберется как это делать

### simple

- всего три стадии и можно начинать отлаживать библиотеку

```bash
# первые две стадии нужны только для предварительной сборки
make stage0-download
make stage1-build

nix-shell
```

### Stage 1

- Вытаскиваем prebuild folder из nix и сохраняем где нибудь в папку debug

- правильно подготавливаем исходники чтобы можно было приступить к сборке

```bash
make stage0-download
```

```bash
make stage1-build
```

- default.nix сбилдит проект с нужным флагами и патчами

- Если первый этап не будет отрабатывать до конца, тогда можно будет вытащить preBuild в ручную
- путь `Pre Build Path:` будет напечатан когда зафейлится первая стадия

```bash
mkdir -p debug/source
cd debug/source
cp -r /nix/store/z47iqmixhnl9vb0h1znp41gfgwvkbzqm-opencv-4.7.0/* .
```

### Stage 2

- После подставляем сохраненный prebuild и nix уже не будет билдить с нуля
- Это уже настроено в shell.nix поэтому просто запускаем

```bash
nix-shell
```

- в конце `nix-shell` должен проинсталить вашу модифицированную opencv в систему и можно будет компилировать
- проекты которые используют opencv и отлаживать

### Test sample

- пример должен собраться
- если еще не запустили nix-shell

```bash
nix-shell
```
- sample

```bash
cd sample
make configure
make build
cd build
```
- далее можно отлаживать, но gdb + `~/.gdbinit` должен быть вот этот https://github.com/symphorien/nixseparatedebuginfod, чтобы он видил отладочные символы
- and gdb-dashboard https://github.com/cyrus-and/gdb-dashboard

- если нет gdb dashboard, можно использовать встроенный

```bash
(gdb) layout src
```
- отлаживаем

```bash
gdb opencv_example
(gdb) b loadsave.cpp:629
(gdb) r
(gdb) next
```

### gdb with python

```bash
gdb python
(gdb) b loadsave.cpp:629
(gdb) run sample.py
(gdb) r
(gdb) next
```

### clean garbage

```bash
nix-store --gc
```
