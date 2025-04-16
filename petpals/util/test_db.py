from util.db_connection import DBConnection

try:
    connection = DBConnection.get_connection()
    if connection.is_connected():
        print("✅ Connected successfully!")
        connection.close()
    else:
        print("❌ Connection not established.")
except Exception as e:
    print(f"❌ Failed: {e}")
