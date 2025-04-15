from dataclasses import dataclass

@dataclass
class MaintenanceRecord:
    maintenance_id: int = None
    asset_id: int = None
    maintenance_date: str = ""
    description: str = ""
