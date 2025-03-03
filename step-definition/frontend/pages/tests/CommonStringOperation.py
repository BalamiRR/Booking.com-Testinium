from robot.api.deco import keyword
import unicodedata

class CommonStringOperation:
    def __init__(self):
        pass
    
    @keyword
    def replace_in_string(self, inputstring, replacestr):
        return inputstring.replace("xx", replacestr).strip()

    @keyword
    def normalize_string(text):
        if text is None:
            return ""
        return unicodedata.normalize("NFKD", text).encode("ASCII", "ignore").decode("utf-8")