import mysql.connector
from datetime import datetime
from dao.asset_management_service import AssetManagementService
from entity.asset import Asset
from entity.asset_allocation import AssetAllocation
from entity.maintenance_record import MaintenanceRecord
from exceptions.asset_not_found_exception import AssetNotFoundException
from exceptions.asset_not_maintain_exception import AssetNotMaintainException
from util.db_conn_util import get_connection

class AssetManagementServiceImpl(AssetManagementService):

    def create_asset(self, asset: Asset) -> None:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = """
            INSERT INTO assets (asset_name, asset_type, purchase_date, price)
            VALUES (%s, %s, %s, %s)
            """
            cursor.execute(query, (asset.asset_name, asset.asset_type, asset.purchase_date, asset.price))
            conn.commit()
            print("✅ Asset added successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def update_asset(self, asset: Asset) -> None:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = """
            UPDATE assets
            SET asset_name = %s, asset_type = %s, purchase_date = %s, price = %s
            WHERE asset_id = %s
            """
            cursor.execute(query, (asset.asset_name, asset.asset_type, asset.purchase_date, asset.price, asset.asset_id))
            conn.commit()
            print("✅ Asset updated successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def delete_asset(self, asset_id: int) -> None:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = "DELETE FROM assets WHERE asset_id = %s"
            cursor.execute(query, (asset_id,))
            conn.commit()
            print("✅ Asset deleted successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def get_asset(self, asset_id: int) -> Asset:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return None
            cursor = conn.cursor()
            query = "SELECT * FROM assets WHERE asset_id = %s"
            cursor.execute(query, (asset_id,))
            result = cursor.fetchone()
            cursor.close()
            if result:
                return Asset(asset_id=result[0], asset_name=result[1], asset_type=result[2], purchase_date=result[3], price=result[4])
            else:
                raise AssetNotFoundException(f"Asset with ID {asset_id} not found.")
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def allocate_asset(self, allocation: AssetAllocation) -> None:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = """
            INSERT INTO asset_allocations (asset_id, employee_id, allocation_date)
            VALUES (%s, %s, %s)
            """
            cursor.execute(query, (allocation.asset_id, allocation.employee_id, allocation.allocation_date))
            conn.commit()
            print("✅ Asset allocated successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def reserve_asset(self, asset_id: int, start_date: str, end_date: str) -> None:
        conn = None
        try:
            # Validate date format before DB operation
            try:
                datetime.strptime(start_date, "%Y-%m-%d")
                datetime.strptime(end_date, "%Y-%m-%d")
            except ValueError:
                print("❌ Invalid date format. Please use YYYY-MM-DD.")
                return

            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = """
            INSERT INTO reservations (asset_id, start_date, end_date)
            VALUES (%s, %s, %s)
            """
            cursor.execute(query, (asset_id, start_date, end_date))
            conn.commit()
            print("✅ Asset reserved successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"❌ Error: {err}")
            print("Please check the information or contact customer care.")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def record_maintenance(self, record: MaintenanceRecord) -> None:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return
            cursor = conn.cursor()
            query = """
            INSERT INTO maintenance_records (asset_id, maintenance_date, description)
            VALUES (%s, %s, %s)
            """
            cursor.execute(query, (record.asset_id, record.maintenance_date, record.description))
            conn.commit()
            print("✅ Maintenance recorded successfully.")
            cursor.close()
        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            if conn and conn.is_connected():
                conn.close()

    def check_asset_availability(self, asset_id: int) -> bool:
        conn = None
        try:
            conn = get_connection()
            if conn is None:
                print("❌ Failed to connect to DB.")
                return False
            cursor = conn.cursor()
            query = "SELECT COUNT(*) FROM reservations WHERE asset_id = %s AND end_date > CURDATE()"
            cursor.execute(query, (asset_id,))
            result = cursor.fetchone()
            cursor.close()
            return result[0] == 0  # Returns True if no active reservation exists
        except mysql.connector.Error as err:
            print(f"Error: {err}")
            return False
        finally:
            if conn and conn.is_connected():
                conn.close()
