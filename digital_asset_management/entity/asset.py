from dataclasses import dataclass

@dataclass
class Asset:
    asset_id: int = None
    asset_name: str = ""
    asset_type: str = ""
    purchase_date: str = ""
    price: float = 0.0
