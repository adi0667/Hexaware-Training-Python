# main.py

from dao.pet_dao import PetDAO
from entity.dog import Dog
from entity.cat import Cat
from util.db_connection import DBConnection

def main():
    # Establish database connection using DBConnection class
    db_connection = DBConnection.get_connection()
    if not db_connection:
        print("Failed to connect to the database. Exiting...")
        return

    pet_dao = PetDAO(db_connection)

    while True:
        print("\nPetPals Management System")
        print("1. Add New Pet")
        print("2. List Available Pets")
        print("3. Record Cash Donation")
        print("4. List Adoption Events")
        print("5. Register for Adoption Event")
        print("6. List  Donations")
        print("7. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            pet_type = input("Enter pet type (Dog/Cat): ").strip().lower()
            name = input("Enter pet name: ").strip()
            age = int(input("Enter pet age: "))
            breed = input("Enter pet breed: ").strip()

            if pet_type == 'dog':
                dog_breed = input("Enter dog breed: ").strip()
                pet = Dog(name, age, breed, dog_breed)
            elif pet_type == 'cat':
                cat_color = input("Enter cat color: ").strip()
                pet = Cat(name, age, breed, cat_color)
            else:
                print("Invalid pet type. Please enter Dog or Cat.")
                continue

            pet_dao.add_pet(pet)

        elif choice == "2":
            print("\nListing Available Pets:")
            pet_dao.list_available_pets()

        elif choice == "3":
            donor_name = input("Enter donor name: ").strip()
            amount = float(input("Enter donation amount: "))
            donation_date = input("Enter donation date (YYYY-MM-DD): ").strip()
            pet_dao.record_cash_donation(donor_name, amount, donation_date)

        elif choice == "4":
            print("\nListing Adoption Events:")
            pet_dao.list_adoption_events()

        elif choice == "5":
            participant_name = input("Enter participant name: ").strip()
            event_id = int(input("Enter event ID: "))
            pet_dao.register_for_adoption_event(participant_name, event_id)

        elif choice == "6":
            print("\nListing Cash Donations:")
            pet_dao.list_cash_donations()  # ✅ New DAO method to implement

        elif choice == "7":
            print("Exiting the program.")
            break

        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
