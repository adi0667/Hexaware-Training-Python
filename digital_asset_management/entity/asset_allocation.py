from dataclasses import dataclass

@dataclass
class AssetAllocation:
    allocation_id: int = None
    asset_id: int = None
    employee_id: int = None
    allocation_date: str = ""
