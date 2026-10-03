# Базовый класс
class Transport:
    def __init__(self, brand, speed):
        self.brand = brand
        self.speed = speed

    def move(self):
        print(f"{self.brand} движется со скоростью {self.speed} км/ч")

    def info(self):
        print(f"Марка: {self.brand}")
        print(f"Скорость: {self.speed} км/ч")


# Производный класс
class Car(Transport):
    def __init__(self, brand, speed, doors):
        super().__init__(brand, speed)
        self.doors = doors

    def move(self):
        print(f"Автомобиль {self.brand} едет по дороге")

    def show_doors(self):
        print(f"Количество дверей: {self.doors}")


# Создание объекта базового класса
transport = Transport("Volvo", 80)

print("Базовый класс:")
transport.info()
transport.move()

print()

# Создание объекта производного класса
car = Car("BMW", 120, 4)

print("Производный класс:")
car.info()
car.move()
car.show_doors()