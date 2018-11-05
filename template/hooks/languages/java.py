from languages.speakable import Speakable



class Mvn(Speakable):
    command = ["mvn", "-B", "-ff", "-N", "-U", "-up", "clean"]

    def getTestCommand(self):
        return self.command + [
                "test", "integration-test", "checkstyle:check", "pmd:check", "pmd:cpd-check", "findbugs:check"]

    def getFile(self):
        return ["pom.xml"]

    def getInstallCommand(self):
        return self.command + ["install", "-DskipTests"]
