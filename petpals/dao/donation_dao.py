from util.db_connection import DBConnection
from exception.custom_exceptions import *


class DonationDAO:
    @staticmethod
    def record_cash_donation(donor_name, amount, donation_date):
        connection = None
        try:
            if amount < 10:
                raise InsufficientFundsException("Minimum donation amount is $10")

            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            query = """
            INSERT INTO donations (donor_name, amount, donation_type, donation_date)
            VALUES (%s, %s, 'Cash', %s)
            """
            values = (donor_name, amount, donation_date)

            cursor.execute(query, values)
            connection.commit()

        except Exception as e:
            raise e
        finally:
            if connection and connection.is_connected():
                cursor.close()
                connection.close()

    @staticmethod
    def list_cash_donations():
        connection = None
        try:
            connection = DBConnection.get_connection()
            cursor = connection.cursor()

            query = """
            SELECT id, donor_name, amount, donation_date
            FROM donations
            WHERE donation_type = 'Cash'
            ORDER BY donation_date DESC
            """
            cursor.execute(query)
            donations = cursor.fetchall()

            if donations:
                print("\n--- Cash Donations ---")
                for donation in donations:
                    print(f"ID: {donation[0]}, Donor: {donation[1]}, Amount: ${donation[2]}, Date: {donation[3]}")
            else:
                print("No cash donations found.")

        except Exception as e:
            print("Error retrieving donations:", e)
        finally:
            if connection and connection.is_connected():
                cursor.close()
                connection.close()
