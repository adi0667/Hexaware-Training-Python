# dao/pet_dao.py

import mysql.connector
from mysql.connector import Error
from entity.pet import Pet
from entity.dog import Dog
from entity.cat import Cat
from exception.custom_exceptions import DatabaseConnectionException
from util.db_connection import DBConnection  # Updated import

class PetDAO:
    def __init__(self, db_connection):
        self.db_connection = db_connection
        self.cursor = self.db_connection.cursor()

    def add_pet(self, pet):
        try:
            if isinstance(pet, Dog):
                self.cursor.execute(
                    "INSERT INTO pets (name, age, breed, pet_type, dog_breed) VALUES (%s, %s, %s, 'Dog', %s)",
                    (pet.get_name(), pet.get_age(), pet.get_breed(), pet.get_dog_breed())
                )
            elif isinstance(pet, Cat):
                self.cursor.execute(
                    "INSERT INTO pets (name, age, breed, pet_type, cat_color) VALUES (%s, %s, %s, 'Cat', %s)",
                    (pet.get_name(), pet.get_age(), pet.get_breed(), pet.get_cat_color())
                )
            else:
                self.cursor.execute(
                    "INSERT INTO pets (name, age, breed, pet_type) VALUES (%s, %s, %s, 'Pet')",
                    (pet.get_name(), pet.get_age(), pet.get_breed())
                )
            self.db_connection.commit()
            print(f"Pet {pet.get_name()} added successfully.")
        except Error as e:
            print(f"Error adding pet: {str(e)}")

    def list_available_pets(self):
        try:
            self.cursor.execute("SELECT * FROM pets")
            pets = self.cursor.fetchall()
            for pet in pets:
                print(f"ID: {pet[0]}, Name: {pet[1]}, Age: {pet[2]}, Breed: {pet[3]}, Pet Type: {pet[4]}")
        except Error as e:
            print(f"Error retrieving pets: {str(e)}")

    def record_cash_donation(self, donor_name, amount, donation_date):
        try:
            self.cursor.execute(
                "INSERT INTO donations (donor_name, amount, donation_type, donation_date) VALUES (%s, %s, 'Cash', %s)",
                (donor_name, amount, donation_date)
            )
            self.db_connection.commit()
            print(f"Cash donation of ${amount} recorded from {donor_name}.")
        except Error as e:
            print(f"Error recording donation: {str(e)}")

    def list_cash_donations(self):
        try:
            self.cursor.execute("SELECT id, donor_name, amount, donation_date FROM donations WHERE donation_type = 'Cash'")
            donations = self.cursor.fetchall()

            if donations:
                print("\n--- Cash Donations ---")
                for donation in donations:
                    print(f"ID: {donation[0]}, Donor: {donation[1]}, Amount: ${donation[2]}, Date: {donation[3]}")
            else:
                print("No cash donations found.")
        except Error as e:
            print(f"Error retrieving donations: {str(e)}")

    def list_adoption_events(self):
        try:
            self.cursor.execute("SELECT * FROM adoption_events")
            events = self.cursor.fetchall()
            for event in events:
                print(f"Event ID: {event[0]}, Event Name: {event[1]}, Event Date: {event[2]}")
        except Error as e:
            print(f"Error retrieving adoption events: {str(e)}")

    def register_for_adoption_event(self, participant_name, event_id):
        try:
            self.cursor.execute(
                "INSERT INTO participants (name, event_id) VALUES (%s, %s)",
                (participant_name, event_id)
            )
            self.db_connection.commit()
            print(f"{participant_name} has been registered for the event {event_id}.")
        except Error as e:
            print(f"Error registering for event: {str(e)}")
