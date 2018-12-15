from languages.speakable import Speakable


class Npm(Speakable):
    command = ["npm"]

    def get_test_command(self):
        return self.command + ["run-script", "verify"]

    def getfile(self):
        return ["package.json"]

    def get_install_command(self):
        return self.command + ["install"]
