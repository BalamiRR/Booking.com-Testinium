import configparser

config = configparser.ConfigParser()
config.read('configuration/config.ini')

class readProperty:
    # @staticmethod
    # def get_env(env):
    #     return dict(config.items(env))
    
    @staticmethod
    def get_main_url(env):
        properties = readProperty.get_env(env)
        return properties.get('url')
