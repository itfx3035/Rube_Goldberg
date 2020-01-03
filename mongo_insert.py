#!/usr/bin/python3

import pymongo

with open('the_value.txt','r') as f:
    the_value = f.read()

m_conn = pymongo.MongoClient('mongodb://localhost:27017/')
mydb = m_conn['mydb']
collection = mydb['mycollection']

record = {'val': the_value}
collection.insert_one(record)