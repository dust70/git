from abc import ABC, abstractmethod

import os.path
import subprocess

class Speakable(ABC):
    @abstractmethod
    def getTestCommand(self):
        raise NotImplementedError

    @abstractmethod
    def getFile(self):
        raise NotImplementedError

    @abstractmethod
    def getInstallCommand(self):
        raise NotImplementedError

    def postCheckout(self):
        if not (os.path.exists("./.git/rebase-merge") and os.path.exists("./.git/rebase-apply")):
            self.remoteChanges("checkout")

    def postMerge(self):
        self.remoteChanges("merge")

    def postRewrite(self):
        self.remoteChanges("rewrite")

    def prePush(self):
        if self.checkFiles():
            print("run pre push command")
            self.call(self.getTestCommand())

    def checkFiles(self):
        result = True
        for file in self.getFile():
            result = os.path.isfile(file)

        return result

    def call(self, command):
        process = subprocess.Popen(command)
        process.communicate()

        if process.returncode != 0:
            raise Exception("Command don't succeed!")

        return process

    def filesToString(self):
        seperator = " "

        return seperator.join(self.getFile())

    def remoteChanges(self, type):
        if self.checkFiles():
            print("run post " + type + " command")
            process = subprocess.Popen(["git", "diff", "HEAD@{1}", "--name-only", "--", self.filesToString()], stdout=subprocess.PIPE)

            if len(process.stdout.readlines()) > 0:
                self.call(self.getInstallCommand())
