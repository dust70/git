from languages.speakable import Speakable



class Make(Speakable):
    command = ["make", "clean", "install"]

    def getTestCommand(self):
        return self.command

    def getFile(self):
        return ["Makefile"]

    def getInstallCommand(self):
        return self.command
