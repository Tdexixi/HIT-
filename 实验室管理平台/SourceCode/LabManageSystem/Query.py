import functools
import operator
import re

import pymysql
from PyQt5.QtWidgets import QMessageBox

HOST = 'localhost'
USER = 'root'
PASSWORD = '123456'
PORT = 3306
DATABASE = 'newsys'


class Query():
    def __init__(self):
        # 连接的数据库信息
        with open("configs.txt", encoding='utf-8') as file:
            content = file.readlines()

        for line in content:
            if re.search(r"HOST\s*=\s*\'(.*?)\'", line) is not None:
                n1 = re.search(r"\'(.*?)\'", line)
                m1 = n1.group(0).strip('\'')
                HOST = m1
            elif re.search(r"USER\s*=\s*\'(.*?)\'", line) is not None:
                n2 = re.search(r"\'(.*?)\'", line)
                m2 = n2.group(0).strip('\'')
                USER = m2
            elif re.search(r"PASSWORD\s*=\s*\'(.*?)\'", line) is not None:
                n3 = re.search(r"\'(.*?)\'", line)
                m3 = n3.group(0).strip('\'')
                PASSWORD = m3
            elif re.search(r"PORT\s*=\s*\'(.*?)\'", line) is not None:
                n4 = re.search(r"\'(.*?)\'", line)
                m4 = n4.group(0).strip('\'')
                PORT = int(m4)
            elif re.search(r"DATABASE\s*=\s*\'(.*?)\'", line) is not None:
                n5 = re.search(r"\'(.*?)\'", line)
                m5 = n5.group(0).strip('\'')
                DATABASE = m5

        try:
            self.db = pymysql.connect(host=HOST,
                                      user=USER,
                                      password=PASSWORD,
                                      port=PORT,
                                      database=DATABASE)
        except:
            print("Error: unable to connect!")

    def close(self):
        self.db.close()

    def fetch(self, sql):
        try:
            cursor = self.db.cursor()
            cursor.execute(sql)
            results = cursor.fetchall()
            return results
        except:
            print("Error: unable to fetch data")

    def execute(self, sql):
        try:
            cursor = self.db.cursor()
            cursor.execute(sql)
            self.db.commit()
        except:
            print("Error: unable to execute " + sql)
