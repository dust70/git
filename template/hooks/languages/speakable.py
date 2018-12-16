import os.path
import subprocess
from abc import abstractmethod

from configuration.configurable import Configurable


class Speakable(Configurable):
    @abstractmethod
    def get_test_command(self):
        raise NotImplementedError

    @abstractmethod
    def get_file(self):
        raise NotImplementedError

    @abstractmethod
    def get_install_command(self):
        raise NotImplementedError

    def post_checkout(self):
        if not (os.path.exists("./.git/rebase-merge") and os.path.exists("./.git/rebase-apply")):
            self.remote_changes()

    def post_merge(self):
        self.remote_changes()

    def post_rewrite(self):
        self.remote_changes()

    def pre_push(self):
        if self.check_files():
            self.call(self.get_test_command())

    def check_files(self):
        result = True
        for file in self.get_file():
            result &= os.path.isfile(file)

        return result

    def call(self, command):
        process = subprocess.Popen(command)
        process.communicate()

        if process.returncode != 0:
            raise Exception("Command don't succeed!")

        return process

    def files_to_string(self):
        return " ".join(self.get_file())

    def remote_changes(self):
        if self.check_files():
            process = subprocess.Popen(
                ["git", "diff", "HEAD@{1}", "--name-only", "--", self.files_to_string()],
                stdout=subprocess.PIPE
            )

            if len(process.stdout.readlines()) > 0:
                self.call(self.get_install_command())
