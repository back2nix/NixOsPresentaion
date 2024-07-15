#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>

int main() {
    // Загрузка изображения
    cv::Mat image = cv::imread("input.jpg");

    if (image.empty()) {
        std::cerr << "Не удалось загрузить изображение." << std::endl;
        return -1;
    }

    // Изменение размера изображения
    cv::Mat resized_image;
    cv::resize(image, resized_image, cv::Size(640, 480));

    // Сохранение измененного изображения
    cv::imwrite("output.jpg", resized_image);

    // Отображение изображения
    cv::imshow("Измененное изображение", resized_image);
    cv::waitKey(0);

    return 0;
}
