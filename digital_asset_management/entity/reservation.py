from dataclasses import dataclass

@dataclass
class Reservation:
    reservation_id: int = None
    asset_id: int = None
    start_date: str = ""
    end_date: str = ""
