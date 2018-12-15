from languages.speakable import Speakable


class Mvn(Speakable):
    command = ["mvn", "-B", "-ff", "-N", "-U", "-up", "clean"]

    def get_test_command(self):
        return self.command \
               + ["test", "integration-test", "checkstyle:check", "pmd:check", "pmd:cpd-check", "findbugs:check"]

    def getfile(self):
        return ["pom.xml"]

    def get_install_command(self):
        return self.command + ["install", "-DskipTests"]
