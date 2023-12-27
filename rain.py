#!/usr/bin/python3

import psycopg2
import sys
from datetime import datetime
from configparser import ConfigParser


class DatabaseManager:
    def __init__(self, config_file):
        self.config = self.read_db_config(config_file)
        self.conn = self.connect()

    def read_db_config(self, filename='/etc/rainRecorder/database.ini', section='postgresql'):
        parser = ConfigParser()
        parser.read(filename)
        db = {}

        if parser.has_section(section):
            params = parser.items(section)
            for param in params:
                db[param[0]] = param[1]
        else:
            raise Exception(f'Section {section} not found in the {filename} file')

        return db

    def connect(self):
        conn = None
        try:
            params = self.config
            conn = psycopg2.connect(**params)
            return conn
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

    def close_connection(self):
        if self.conn is not None:
            self.conn.close()

class RainDataInsert():
    def __init__(self, db_manager):
        #super().__init__()
        self.db_manager = db_manager

    def save_to_database(self, date_time, volume):
        try:
            cursor = self.db_manager.conn.cursor()
            cursor.execute("INSERT INTO rain_data (date_time, volume) VALUES (%s, %s)", (date_time, volume))
            self.db_manager.conn.commit()
            print("Record inserted successfully")
        except (Exception, psycopg2.Error) as error:
            print(f"Error inserting data into the database: {error}")
        finally:
            if cursor:
                cursor.close()

if __name__ == "__main__":
    db_manager = DatabaseManager('/etc/rainRecorder/database.ini')
    rainInsert = RainDataInsert(db_manager)

    volume = sys.argv[1]

    if volume.isnumeric():
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        rainInsert.save_to_database(now, volume)
    else:
        print(f"{volume} is not a number")

