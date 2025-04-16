from entity.pet import Pet  # Import Pet class from pet.py

class Cat(Pet):
    def __init__(self, name, age, breed, cat_color):
        super().__init__(name, age, breed)  # Call the constructor of the Pet class
        self.cat_color = cat_color

    def __str__(self):
        return f"Cat(name={self.name}, age={self.age}, breed={self.breed}, cat_color={self.cat_color})"

    # Getter and setter for cat_color
    def get_cat_color(self):
        return self.cat_color

    def set_cat_color(self, cat_color):
        self.cat_color = cat_color
