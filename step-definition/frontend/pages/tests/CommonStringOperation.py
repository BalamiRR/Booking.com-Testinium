from robot.api.deco import keyword

class CommonStringOperation:
    def __init__(self):
        pass
    
    @keyword
    def replace_in_string(self, inputstring, replacestr):
        return inputstring.replace("xxxxx", replacestr)