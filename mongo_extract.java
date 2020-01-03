package mongo_extract;

import com.mongodb.client.MongoDatabase; 
import com.mongodb.MongoClient; 
import com.mongodb.client.MongoCollection; 
import java.io.PrintWriter;
import org.bson.Document;  


public class Mongo_extract {

    public static void main(String[] args) {

      MongoClient mongo = new MongoClient( "localhost" , 27017 ); 
      MongoDatabase database = mongo.getDatabase("mydb");
      MongoCollection<Document> collection = database.getCollection("mycollection"); 
      Document myDoc = collection.find().first();
      String val = myDoc.getString("val");
      try
      {
        PrintWriter fwriter = new PrintWriter("the_value_from_mongo.txt", "UTF-8");
        fwriter.print(val);
        fwriter.close();
      } catch (Exception e){}
    }
}
