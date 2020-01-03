#!/usr/bin/python3

import os
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3'
os.environ['JAVA_HOME'] = '/usr/lib/jvm/java-8-openjdk-amd64'

import pyspark
from pyspark import SparkContext

sc = SparkContext.getOrCreate()

with open('the_value_from_mongo.txt','r') as f:
    the_num = int(f.read())
the_num = int(the_num/2)

ds = [the_num for x in range(the_num)]
nums = sc.parallelize(ds)

nums_x2 = nums.map(lambda x: x*2)
rd = nums_x2.reduce(lambda x1,x2: max(x1,x2))

with open('the_value_from_spark.txt','w') as f:
    f.write(str(rd))

os.environ['JAVA_HOME'] = '/usr/lib/jvm/java-11-openjdk-amd64'


