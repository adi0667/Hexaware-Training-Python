class AssetNotMaintainException(Exception):
    def __init__(self, message="Asset cannot be maintained at the moment."):
        self.message = message
        super().__init__(self.message)
