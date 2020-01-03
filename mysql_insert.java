import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.CallableStatement;
import java.io.*;

class mysql_insert {
    public static void main (String[] Args) {
	try {
	    File fl = new File("the_value_from_ml.txt");
	    BufferedReader br = new BufferedReader(new FileReader(fl));
	    String the_value = br.readLine();
	    br.close();
	    
	    Connection mcon = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306","root","pass");
	    Statement st=mcon.createStatement();
	    st.executeUpdate("CREATE DATABASE myvaldb;");
	    st.execute("USE myvaldb;");
	    st.execute("CREATE TABLE myvaltab( val int(6));");
	    st.execute("INSERT INTO myvaltab(val) VALUES("+the_value+");");
	    st.execute("CREATE PROCEDURE myproc()  "+
		       "BEGIN "+
		       "SELECT val FROM myvaltab INTO OUTFILE '/tmp/myval.txt'; "+
		       "END ");
	    CallableStatement cst=mcon.prepareCall("{call myproc()}");
	    cst.execute();
	    st.close();
	    mcon.close();
	} catch (Exception e1) {System.out.println(e1.getMessage());}


    }
}

