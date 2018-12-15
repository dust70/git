from languages.speakable import Speakable

import subprocess


class Composer(Speakable):
    command = ["composer"]

    def get_test_command(self):
        return self.command + ["verify"]

    def getfile(self):
        return ["composer.lock"]

    def get_install_command(self):
        return self.command + ["install", "--no-interaction"]


class Php:
    def precommit(self):
        process = subprocess.Popen(
            ["git", "diff-index", "--diff-filter=ACMRT", "--name-only", "HEAD", "--"],
            stdout=subprocess.PIPE
        )
        for l in process.stdout.readlines():
            check = subprocess.Popen(["php", "-l", l.strip(), ">", "/dev/null"])
            check.communicate()

            if check.returncode != 0:
                raise Exception("Command don't succeed!")
