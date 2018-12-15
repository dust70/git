import subprocess
from abc import abstractmethod

from configuration.configurable import Configurable


class Linty(Configurable):
    @abstractmethod
    def get_command(self, file):
        raise NotImplementedError

    def precommit(self):
        if self.is_active():
            process = subprocess.Popen(
                ["git", "diff-index", "--diff-filter=ACMRT", "--name-only", "HEAD", "--"],
                stdout=subprocess.PIPE
            )
            for file in process.stdout.readlines():
                check = subprocess.Popen(self.get_command(file.strip()))
                check.communicate()

                if check.returncode != 0:
                    raise Exception("Command don't succeed!")
