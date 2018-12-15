import json
from abc import ABC, abstractmethod


class Configurable(ABC):
    @abstractmethod
    def get_config(self):
        raise NotImplementedError

    @abstractmethod
    def get_key(self):
        raise NotImplementedError

    def get_configuration(self):
        key = self.get_key()
        result = self.get_config()
        file_config = {}

        try:
            with open(".git/hooksconfig", "r") as file:
                json_config = json.load(file)
                if key in json_config:
                    file_config = json_config[key]
        except EnvironmentError:
            pass

        return {**result, **file_config}

    def is_active(self):
        if "active" in self.get_configuration():
            return self.get_configuration()["active"]

        return True
