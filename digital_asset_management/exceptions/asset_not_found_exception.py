class AssetNotFoundException(Exception):
    def __init__(self, message="Asset not found in the system."):
        self.message = message
        super().__init__(self.message)
