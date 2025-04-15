import unittest
from unittest.mock import patch, MagicMock
from dao.asset_management_service_impl import AssetManagementServiceImpl
from entity.asset import Asset
from entity.asset_allocation import AssetAllocation
from entity.maintenance_record import MaintenanceRecord
from exceptions.asset_not_found_exception import AssetNotFoundException
from exceptions.asset_not_maintain_exception import AssetNotMaintainException


class TestAssetManagementService(unittest.TestCase):

    @patch('dao.asset_management_service_impl.get_connection')
    def test_create_asset(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        asset = Asset(asset_name="Laptop", asset_type="Electronics", purchase_date="2025-01-01", price=1000.00)
        service = AssetManagementServiceImpl()

        service.create_asset(asset)
        mock_cursor.execute.assert_called_once_with(
            """
            INSERT INTO assets (asset_name, asset_type, purchase_date, price)
            VALUES (%s, %s, %s, %s)
            """,
            ("Laptop", "Electronics", "2025-01-01", 1000.00)
        )
        mock_conn.commit.assert_called_once()

    @patch('dao.asset_management_service_impl.get_connection')
    def test_get_asset(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        asset_id = 1
        mock_cursor.fetchone.return_value = (1, "Laptop", "Electronics", "2025-01-01", 1000.00)
        service = AssetManagementServiceImpl()

        asset = service.get_asset(asset_id)

        self.assertEqual(asset.asset_id, 1)
        self.assertEqual(asset.asset_name, "Laptop")
        self.assertEqual(asset.asset_type, "Electronics")
        self.assertEqual(asset.purchase_date, "2025-01-01")
        self.assertEqual(asset.price, 1000.00)

    @patch('dao.asset_management_service_impl.get_connection')
    def test_get_asset_not_found(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        asset_id = 999
        mock_cursor.fetchone.return_value = None
        service = AssetManagementServiceImpl()

        with self.assertRaises(AssetNotFoundException):
            service.get_asset(asset_id)

    @patch('dao.asset_management_service_impl.get_connection')
    def test_allocate_asset(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        allocation = AssetAllocation(asset_id=1, employee_id=101, allocation_date="2025-01-10")
        service = AssetManagementServiceImpl()

        service.allocate_asset(allocation)

        mock_cursor.execute.assert_called_once_with(
            """
            INSERT INTO asset_allocations (asset_id, employee_id, allocation_date)
            VALUES (%s, %s, %s)
            """,
            (1, 101, "2025-01-10")
        )
        mock_conn.commit.assert_called_once()

    @patch('dao.asset_management_service_impl.get_connection')
    def test_reserve_asset(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        service = AssetManagementServiceImpl()
        service.reserve_asset(1, "2025-01-15", "2025-01-20")

        mock_cursor.execute.assert_called_once_with(
            """
            INSERT INTO reservations (asset_id, start_date, end_date)
            VALUES (%s, %s, %s)
            """,
            (1, "2025-01-15", "2025-01-20")
        )
        mock_conn.commit.assert_called_once()

    @patch('dao.asset_management_service_impl.get_connection')
    def test_record_maintenance(self, mock_get_connection):
        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_connection.return_value = mock_conn

        maintenance_record = MaintenanceRecord(asset_id=1, maintenance_date="2025-01-10", description="Battery replacement")
        service = AssetManagementServiceImpl()

        service.record_maintenance(maintenance_record)

        mock_cursor.execute.assert_called_once_with(
            """
            INSERT INTO maintenance_records (asset_id, maintenance_date, description)
            VALUES (%s, %s, %s)
            """,
            (1, "2025-01-10", "Battery replacement")
        )
        mock_conn.commit.assert_called_once()


if __name__ == '__main__':
    unittest.main()
