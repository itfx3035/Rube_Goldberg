#!/bin/sh

echo "========== Tools ==================================================="
echo " - docker"
echo " - mongo"
echo " - mysql"
echo " - python3, pymongo, pandas scikit-learn"
echo " - OpenJDK 9, OpenJDK 11"
echo " - some java libs"
echo "===================================================================="
sleep 5

echo "========== Collecting tools ========================================"
echo ""
echo "> apt-get update"
sleep 1
apt-get update

sleep 1
echo ""
echo "> apt-get install -y docker.io"
sleep 1
apt-get install -y docker.io
sleep 1

echo ""
echo "> docker pull mongo"
sleep 1
docker pull mongo

sleep 1
echo ""
echo "> docker run -d -p 27017-27019:27017-27019 --name mongod mongo"
sleep 1
docker run -d -p 27017-27019:27017-27019 --name mongod mongo

sleep 1
echo ""
echo "> docker pull mysql"
sleep 1
docker pull mysql

sleep 1
echo ""
echo "> docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass --name mysqld mysql --secure-file-priv=/tmp"
sleep 2
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass --name mysqld mysql --secure-file-priv=/tmp


sleep 1
echo ""
echo "> apt-get install -y default-jdk openjdk-8-jdk"
sleep 1
apt-get install -y default-jdk openjdk-8-jdk

sleep 1
echo ""
echo "> wget https://repo1.maven.org/maven2/org/mongodb/bson/3.6.3/bson-3.6.3.jar"
sleep 1
wget https://repo1.maven.org/maven2/org/mongodb/bson/3.6.3/bson-3.6.3.jar

sleep 1
echo ""
echo "> wget wget https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.11.2/mongo-java-driver-3.11.2.jar"
sleep 1
wget https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.11.2/mongo-java-driver-3.11.2.jar

sleep 1
echo ""
echo "> wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.18/mysql-connector-java-8.0.18.jar"
sleep 1
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.18/mysql-connector-java-8.0.18.jar


echo ""
echo "> apt-get install -y python3 python3-pip"
sleep 1
apt-get install -y python3 python3-pip

sleep 1
echo ""
echo "> pip3 install pymongo pandas scikit-learn pyspark"
sleep 1
pip3 install pymongo pandas scikit-learn pyspark

echo "========== Done collecting tools =================================="
sleep 5





echo "========== write our value (42) to file ============================"
echo "> echo 42 > the_value.txt"
sleep 1
echo 42 > the_value.txt
echo "========== Done ===================================================="
sleep 5

echo ""
echo "========== Run python script: insert value to mongo ================"
echo "> python3 mongo_insert.py"
sleep 1
python3 mongo_insert.py
echo "========== Done ===================================================="

sleep 5
echo ""
echo "========== Run java program: extract value from  mongo ============="
echo "> java -classpath bson-3.6.3.jar:mongo-java-driver-3.11.2.jar mongo_extract.java"
sleep 1
java -classpath bson-3.6.3.jar:mongo-java-driver-3.11.2.jar mongo_extract.java
sleep 1
echo "========== Done ===================================================="

sleep 5
echo ""
echo "========== Run python script: playing with spark ==================="
echo "> python3 pyspark_trick.py"
sleep 1
python3 pyspark_trick.py
echo "========== Done ===================================================="

sleep 5
echo ""
echo "========== Run python script: playing with scikit-learn ============"
echo "> python3 ml_trick.py"
sleep 1
python3 ml_trick.py
echo "========== Done ===================================================="

sleep 5
echo ""
echo "========== Run java program: playing with mysql ==================="
echo "> java -classpath mysql-connector-java-8.0.18.jar mysql_insert.java"
sleep 1
java -classpath mysql-connector-java-8.0.18.jar mysql_insert.java
echo "========== Done ==================================================="

sleep 5
echo ""
echo "========== Get file from docker ===================================="
echo "> docker cp mysqld:/tmp/myval.txt the_value_from_mysql.txt"
sleep 1
docker cp mysqld:/tmp/myval.txt the_value_from_mysql.txt
echo "========== Done ==================================================="



sleep 5
echo ""
echo "========== Remove docker container and temporary files ============="
echo "> docker stop mongod"
docker stop mongod

echo "> docker rm -v mongod"
docker rm -v mongod
sleep 1

echo "> docker stop mysqld"
docker stop mysqld

echo "> docker rm -v mysqld"
docker rm -v mysqld
sleep 1


echo "> rm bson-3.6.3.jar"
rm bson-3.6.3.jar

echo "> rm mongo-java-driver-3.11.2.jar"
rm mongo-java-driver-3.11.2.jar

echo "> rm mysql-connector-java-8.0.18.jar"
rm mysql-connector-java-8.0.18.jar

echo "> rm the_value.txt"
rm the_value.txt

echo "> rm the_value_from_mongo.txt"
rm the_value_from_mongo.txt

echo "> rm the_value_from_spark.txt"
rm the_value_from_spark.txt

echo "> rm the_value_from_ml.txt"
rm the_value_from_ml.txt
echo "========== Done ==================================================="

sleep 5
echo ""
echo "OUR VALUE IS:"
cat the_value_from_mysql.txt

rm the_value_from_mysql.txt