from languages.speakable import Speakable



class Npm(Speakable):
    command = ["npm"]

    def getTestCommand(self):
        return self.command + ["run-script", "verify"]

    def getFile(self):
        return ["package.json"]

    def getInstallCommand(self):
        return self.command + ["install"]
