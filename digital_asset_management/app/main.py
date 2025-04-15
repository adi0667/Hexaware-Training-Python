from dao.asset_management_service_impl import AssetManagementServiceImpl
from entity.asset import Asset
from entity.asset_allocation import AssetAllocation
from entity.maintenance_record import MaintenanceRecord
from exceptions.asset_not_found_exception import AssetNotFoundException
from exceptions.asset_not_maintain_exception import AssetNotMaintainException
from datetime import datetime

def display_menu():
    print("\nDigital Asset Management System")
    print("1. Add Asset")
    print("2. Update Asset")
    print("3. Delete Asset")
    print("4. View Asset")
    print("5. Allocate Asset")
    print("6. Reserve Asset")
    print("7. Record Maintenance")
    print("8. Check Asset Availability")
    print("9. Exit")

def main():
    service = AssetManagementServiceImpl()

    while True:
        display_menu()
        choice = input("\nEnter your choice: ")

        if choice == '1':
            asset_name = input("Enter asset name: ")
            asset_type = input("Enter asset type: ")
            purchase_date = input("Enter purchase date (YYYY-MM-DD): ")
            price = float(input("Enter asset price: "))
            asset = Asset(asset_name=asset_name, asset_type=asset_type, purchase_date=purchase_date, price=price)
            service.create_asset(asset)
            print("Asset added successfully.")

        elif choice == '2':
            asset_id = int(input("Enter asset ID to update: "))
            try:
                asset = service.get_asset(asset_id)
                asset_name = input(f"Enter new asset name (current: {asset.asset_name}): ")
                asset_type = input(f"Enter new asset type (current: {asset.asset_type}): ")
                purchase_date = input(f"Enter new purchase date (current: {asset.purchase_date}): ")
                price = float(input(f"Enter new price (current: {asset.price}): "))
                asset.asset_name = asset_name
                asset.asset_type = asset_type
                asset.purchase_date = purchase_date
                asset.price = price
                service.update_asset(asset)
                print("Asset updated successfully.")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '3':
            asset_id = int(input("Enter asset ID to delete: "))
            try:
                service.delete_asset(asset_id)
                print("Asset deleted successfully.")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '4':
            asset_id = int(input("Enter asset ID to view: "))
            try:
                asset = service.get_asset(asset_id)
                print(f"\nAsset ID: {asset.asset_id}")
                print(f"Name: {asset.asset_name}")
                print(f"Type: {asset.asset_type}")
                print(f"Purchase Date: {asset.purchase_date}")
                print(f"Price: {asset.price}")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '5':
            asset_id = int(input("Enter asset ID to allocate: "))
            employee_id = int(input("Enter employee ID: "))
            allocation_date = input("Enter allocation date (YYYY-MM-DD): ")
            allocation = AssetAllocation(asset_id=asset_id, employee_id=employee_id, allocation_date=allocation_date)
            try:
                service.allocate_asset(allocation)
                print("Asset allocated successfully.")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '6':
            asset_id = int(input("Enter asset ID to reserve: "))
            start_date = input("Enter start date (YYYY-MM-DD): ")
            end_date = input("Enter end date (YYYY-MM-DD): ")
            try:
                service.reserve_asset(asset_id, start_date, end_date)
                print("Asset reserved successfully.")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '7':
            asset_id = int(input("Enter asset ID for maintenance: "))
            maintenance_date = input("Enter maintenance date (YYYY-MM-DD): ")
            description = input("Enter maintenance description: ")
            record = MaintenanceRecord(asset_id=asset_id, maintenance_date=maintenance_date, description=description)
            try:
                service.record_maintenance(record)
                print("Maintenance recorded successfully.")
            except AssetNotFoundException as e:
                print(e)

        elif choice == '8':
            asset_id = int(input("Enter asset ID to check availability: "))
            available = service.check_asset_availability(asset_id)
            if available:
                print("Asset is available.")
            else:
                print("Asset is not available.")

        elif choice == '9':
            print("Exiting the system...")
            break

        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
