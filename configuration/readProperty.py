import configparser
from datetime import datetime, timedelta

config = configparser.ConfigParser()
config.read('configuration/config.ini')

class readProperty:
    @staticmethod
    def get_env(env):
        return dict(config.items(env))
    
    @staticmethod
    def get_main_url(env):
        properties = readProperty.get_env(env)
        return properties.get('url')
    
    # @staticmethod
    # def dynamic_date_locator(date):
    #     return  "//span[@data-date='${date}']"
    
    # @staticmethod
    # def get_date(self, days_from_now):
    #     return (datetime.now() + timedelta(days=int(days_from_now))).strftime('%#Y-%m-%#d')

   