from languages.linty import Linty
from languages.speakable import Speakable


class Composer(Speakable):
    command = ["composer"]

    def get_test_command(self):
        return self.command + ["verify"]

    def getfile(self):
        return ["composer.lock"]

    def get_install_command(self):
        return self.command + ["install", "--no-interaction"]


class Php(Linty):
    def get_command(self, file):
        return ["php", "-l", file]

    # def get_config(self):
    #    return {}

    def get_key(self):
        return "php"
