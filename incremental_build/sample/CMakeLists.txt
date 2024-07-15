cmake_minimum_required(VERSION 3.0)
project(OpenCVExample)


# set(CMAKE_PREFIX_PATH "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2/build/opencv/build/install_dir")

# Найдем пакет OpenCV
find_package(OpenCV REQUIRED)

# Добавим исполняемый файл
add_executable(opencv_example main.cpp)

# Связываем OpenCV с исполняемым файлом
target_link_libraries(opencv_example ${OpenCV_LIBS})
