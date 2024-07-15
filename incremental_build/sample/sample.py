import cv2
import numpy as np

# Загрузка изображения
image = cv2.imread("input.jpg")

if image is None:
    print("Не удалось загрузить изображение.")
    exit()

# Изменение размера изображения
resized_image = cv2.resize(image, (640, 480))

# Сохранение измененного изображения
cv2.imwrite("output.jpg", resized_image)

# Отображение изображения
cv2.imshow("Измененное изображение", resized_image)
cv2.waitKey(0)
cv2.destroyAllWindows()
