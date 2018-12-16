from languages.linty import Linty


class Python(Linty):
    def get_command(self, file):
        return ["python3", "-m", "py_compile", file]

    def get_key(self):
        return "python"
