import os
import mysql.connector
from mysql.connector import Error
from util.db_property_util import read_db_properties

def get_connection():
    try:
        # Dynamically build the absolute path to db.properties
        base_dir = os.path.dirname(os.path.abspath(__file__))  # This is /.../util
        properties_path = os.path.join(base_dir, '..', 'config', 'db.properties')

        # Normalize path (handles ../ on Windows/Linux/Mac)
        properties_path = os.path.normpath(properties_path)

        props = read_db_properties(properties_path)

        conn = mysql.connector.connect(
            host=props['host'],
            port=props['port'],
            user=props['user'],
            password=props['password'],
            database=props['database']
        )

        if conn.is_connected():
            return conn

    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None
