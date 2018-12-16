import json
from abc import ABC, abstractmethod


class Configurable(ABC):
    config = {}

    def get_config(self):
        return {
            "active": True,
            "install": [],
            "test": [],
        }

    @abstractmethod
    def get_key(self):
        raise NotImplementedError

    def get_configuration(self):
        key = self.get_key()
        if key not in self.config or not bool(self.config[key]):
            result = self.get_config()
            file_config = {}

            try:
                with open(".git/hooksconfig", "r") as file:
                    json_config = json.load(file)
                    if key in json_config:
                        file_config = json_config[key]
            except EnvironmentError:
                pass

            self.config[key] = {**result, **file_config}

        return self.config[key]

    def is_active(self):
        if "active" in self.get_configuration():
            return self.get_configuration()["active"]

        return True
