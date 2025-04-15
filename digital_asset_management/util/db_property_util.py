import os

def read_db_properties(filepath: str) -> dict:
    properties = {}
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                key, value = line.split('=', 1)
                properties[key.strip()] = value.strip()
    return properties
