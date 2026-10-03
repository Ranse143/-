numbers = [5, -3, 8, -7, 2, -1, 10]
max_element = max(numbers)
min_element = min(numbers)
max_index = numbers.index(max_element)
min_index = numbers.index(min_element)
left = min(max_index, min_index)
right = max(max_index, min_index)
sum_negative = 0

for i in range(left + 1, right):
    if numbers[i] < 0:
        sum_negative += numbers[i]

print("Массив:", numbers)
print("Максимальный элемент:", max_element)
print("Минимальный элемент:", min_element)
print("Позиция максимума:", max_index)
print("Позиция минимума:", min_index)
print("Сумма отрицательных элементов между ними:", sum_negative)