from languages.speakable import Speakable


class Composer(Speakable):
    command = ["composer"]

    def get_file(self):
        return ["composer.lock"]

    def get_install_command(self):
        return self.command + ["install", "--no-interaction"]

    def get_key(self):
        return "composer"

    def get_test_command(self):
        return self.command + ["verify"]
