from languages.speakable import Speakable

import subprocess

class Composer(Speakable):
    command = ["composer"]

    def getTestCommand(self):
        return self.command + ["verify"]

    def getFile(self):
        return ["composer.lock"]

    def getInstallCommand(self):
        return self.command + ["install", "--no-interaction"]

class Php():
    def preCommit(self):
        print("run pre commit command")

        process = subprocess.Popen(["git", "diff-index", "--diff-filter=ACMRT", "--name-only", "HEAD", "--"], stdout=subprocess.PIPE)
        for l in process.stdout.readlines():
            check = subprocess.Popen(["php", "-l", l.strip(), ">", "/dev/null"])
            check.communicate()

            if check.returncode != 0:
                raise Exception("Command don't succeed!")
