from abc import ABC, abstractmethod
from entity.asset import Asset
from entity.asset_allocation import AssetAllocation
from entity.maintenance_record import MaintenanceRecord
from exceptions.asset_not_found_exception import AssetNotFoundException
from exceptions.asset_not_maintain_exception import AssetNotMaintainException

class AssetManagementService(ABC):

    @abstractmethod
    def create_asset(self, asset: Asset) -> None:
        """Create a new asset in the system."""
        pass

    @abstractmethod
    def update_asset(self, asset: Asset) -> None:
        """Update an existing asset's details."""
        pass

    @abstractmethod
    def delete_asset(self, asset_id: int) -> None:
        """Delete an asset from the system."""
        pass

    @abstractmethod
    def get_asset(self, asset_id: int) -> Asset:
        """Fetch an asset by its ID."""
        pass

    @abstractmethod
    def allocate_asset(self, allocation: AssetAllocation) -> None:
        """Allocate an asset to an employee or department."""
        pass

    @abstractmethod
    def reserve_asset(self, asset_id: int, start_date: str, end_date: str) -> None:
        """Reserve an asset for use between specific dates."""
        pass

    @abstractmethod
    def record_maintenance(self, record: MaintenanceRecord) -> None:
        """Record maintenance details for an asset."""
        pass

    @abstractmethod
    def check_asset_availability(self, asset_id: int) -> bool:
        """Check if the asset is available for allocation/maintenance."""
        pass
