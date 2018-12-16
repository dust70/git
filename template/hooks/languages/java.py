from languages.speakable import Speakable


class Mvn(Speakable):
    command = ["mvn", "-B", "-ff", "-N", "-U", "-up", "clean"]

    def get_file(self):
        return ["pom.xml"]

    def get_install_command(self):
        return self.command + ["install", "-DskipTests"]

    def get_key(self):
        return "mvn"

    def get_test_command(self):
        return self.command \
               + ["test", "integration-test", "checkstyle:check", "pmd:check", "pmd:cpd-check", "findbugs:check"]
