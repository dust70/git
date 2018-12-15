from languages.speakable import Speakable


class Make(Speakable):
    command = ["make", "clean", "install"]

    def get_test_command(self):
        return self.command

    def getfile(self):
        return ["Makefile"]

    def get_install_command(self):
        return self.command
