from dataclasses import dataclass

@dataclass
class Employee:
    employee_id: int = None
    first_name: str = ""
    last_name: str = ""
    email: str = ""
    phone_number: str = ""
    department: str = ""
    hire_date: str = ""
