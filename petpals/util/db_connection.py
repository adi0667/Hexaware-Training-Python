import mysql.connector
from mysql.connector import Error
import configparser
import os
from exception.custom_exceptions import DatabaseConnectionException

class DBConnection:
    @staticmethod
    def get_connection():
        try:
            # Build the path to the config file
            config_path = os.path.join(os.path.dirname(__file__), '..', 'db_config.ini')
            config = configparser.ConfigParser()
            config.read(config_path)

            if 'database' not in config:
                raise KeyError("Missing 'database' section in db_config.ini")

            return mysql.connector.connect(
                host=config['database']['host'],
                user=config['database']['user'],
                password=config['database']['password'],
                database=config['database']['name']
            )
        except KeyError as ke:
            print(f"Missing configuration in db_config.ini: {ke}")
            raise
        except Error as e:
            raise DatabaseConnectionException(f"Database connection failed: {str(e)}")
