from languages.speakable import Speakable


class Make(Speakable):
    command = ["make", "clean", "install"]

    def get_config(self):
        return super(Make, self).get_config() + {
            "active": False
         }

    def get_file(self):
        return ["Makefile"]

    def get_install_command(self):
        return self.command

    def get_key(self):
        return "make"

    def get_test_command(self):
        return self.command
