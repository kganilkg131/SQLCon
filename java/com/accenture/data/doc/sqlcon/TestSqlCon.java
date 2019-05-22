package com.accenture.data.doc.sqlcon;

public class TestSqlCon {

	public static void main(String[] args) {
		
		String sql = "select * abort eventname analyse from event where rownum < 3;";
//		String path = "inst/csv/conversionPatterns.csv";
//		sql = SqlConvert.convertSqlWithPath(sql, "Netezza", "Hive", null, null, path);
//		System.out.println("here    "+  sql);
		
		//sql = "SELECT (LastName + '& ' + FirstName) AS Name FROM Person.Person ORDER BY LastName ASC + FirstName ASC;";
	    //sql = "SELECT CONCAT(\"SQL \", \"(Tutorial) \", \"is \", \"fun!\") AS ConcatenatedString;";
		sql = "SELECT CONCAT(\"SQL \", \"(Tutorial) \", \"is \", \"fun!\") AS ConcatenatedString;";
		
		String path = "inst/csv/justTest.csv";
		sql = SqlTranslate.translateSqlWithPath(sql, "redshift", null, null, path);
		System.out.println("here    "+  sql);
		
//		String sql = "IF OBJECT_ID('test', 'U') IS NULL CREATE TABLE test (	x BIGINT);";
//		String path = "inst/csv/replacementPatterns.csv";
//		sql = SqlTranslate.translateSqlWithPath(sql, "oracle", null, null, path);
//		System.out.println(sql);
		
//		String sql = "select * eventname from event where rownum < 3;";
//		String path = "inst/csv/replacementPatterns.csv";
//		sql = SqlTranslate.translateSqlWithPath(sql, "netezza", null, null, path);
//		System.out.println("here    "+  sql);
		
		
		
//		Pattern pattern = Pattern.compile("^((?!FROM).)*$");
//		System.out.println(pattern.matcher("SELECT * blaat b;").matches());
		
//		String sql = "SELECT * FROM table {@a = true} ?  {WHERE name = '@name'};";
//		sql = SqlRender.renderSql(sql, new String[]{"name", "a"}, new String[]{"NA\\joe", "true"});
//		System.out.println(sql);	
//		
//		String sourceSql = "SELECT TOP 10 * FROM my_table WHERE a = b;";
//		String sql;
//		sql = SqlTranslate.translateSqlWithPath(sourceSql, "postgresql", null, null, path);
//		System.out.println(sql);		
//		
//		sql = SqlTranslate.translateSqlWithPath(sourceSql, "oracle", null, null, path);
//		System.out.println(sql);
		
//		String sql = "SELECT * FROM @my_table";
//		for (String warning : SqlRender.checkSql(sql, new String[]{"my_table"}, new String[]{"asdfs"}))
//			System.out.println(warning);

//		String sql = "CREATE TABLE abcdefghijklmnopqrstuvwxyz1234567890;";
//		for (String warning : SqlTranslate.check(sql, ""))
//			System.out.println(warning);
	}
	
	public String setdoubleQuote(String myText) {
	    String quoteText = "";
	    if (!myText.isEmpty()) {
	        quoteText = "\"" + myText + "\"";
	    }
	    return quoteText;
	}	
}
