from entity.pet import Pet  # Import Pet class from pet.py

class Dog(Pet):
    def __init__(self, name, age, breed, dog_breed):
        super().__init__(name, age, breed)  # Call the constructor of the Pet class
        self.dog_breed = dog_breed

    def __str__(self):
        return f"Dog(name={self.name}, age={self.age}, breed={self.breed}, dog_breed={self.dog_breed})"

    # Getter and setter for dog_breed
    def get_dog_breed(self):
        return self.dog_breed

    def set_dog_breed(self, dog_breed):
        self.dog_breed = dog_breed
