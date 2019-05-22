SQLCon
=========


Introduction
============
This is an R package for rendering parameterized SQL, and translating it to different SQL dialects. This can also be used as a stand-alone Java library and a command-line executable.

Features
========
- Supports a simple markup syntax for making SQL parameterized, and renders parameterized SQL (containing the markup syntax) to executable SQL
- The syntax supports defining default parameter values
- The syntax supports if-then-else structures
- Has functions for translating SQL from one dialect (Microsoft SQL Server) to other dialects (Oracle, PostgreSQL, Amazon RedShift, Impala, IBM Netezza, Google BigQuery, Microsoft PDW, and SQLite)
- Can be used as R package, Java library, or as stand-alone executable through a command-line interface

Examples
========
This exampe shows the use of parameters, as well as SQLCon's {if} ? {then} : {else} syntax:

```r
sql <- render("SELECT * FROM @a; {@b != ''}?{USE @b;}", a = "my_table", b = "my_schema")
```

will produce the variable `sql` containing this value: 

```
"SELECT * FROM my_table; USE my_schema;"
```

subsequently running this code

```r
sql <- translate(sql, "oracle")
```

will produce the variable `sql` containing this value: 

```
"SELECT * FROM my_table; ALTER SESSION SET current_schema =  my_schema;"
```

Technology
==========
The SqlCon package is an R package wrapped around a Java library. The rJava package is used as interface.

The Java library is available as a JAR file.

System Requirements
===================
Running the package requires R with the package rJava installed. Also requires Java 1.6 or higher.

Installation
=============
## R package

In R, to install the latest stable version, install from CRAN:

```r
install.packages("SQLConRender")
```
  
To install the latest development version, install from GitHub:

```r
install.packages("devtools")
devtools::install_github("kganilkg131/SQLCon")
```

Once installed, you can try out SQLCon in a Shiny app that comes with the package:

```r
library(SQLCon)
launchSQLConDeveloper()
```

## Java library
You can fetch the JAR file in the inst/java folder of this repository, or use Maven:

1. First add the SQLCon repository so that maven can find and download the SQLCon artifact automatically:
```xml
<repositories>
	<repository>
		<id>ohdsi</id>
		<name>repo.accenture.data.doc.com</name>
		<url>http://repo.accenture.data.doc.com:8085/nexus/content/repositories/releases</url>
	</repository>
	<repository>
		<id>ohdsi.snapshots</id>
		<name>repo.accenture.data.doc.com-snapshots</name>
		<url>http://repo.accenture.data.doc.com:8085/nexus/content/repositories/snapshots</url>
		<releases>
			<enabled>false</enabled>
		</releases>
		<snapshots>
			<enabled>true</enabled>
		</snapshots>
	</repository>
</repositories>
```
2: Include the SQLCon dependency in your pom.xml
```xml
<dependency>
	<groupId>com.accenture.data.doc.sqlcon</groupId>
	<artifactId>SQLCon</artifactId>
	<version>1.0.0-SNAPSHOT</version>
</dependency>
```

## Command-line executable
You can fetch the JAR file in the inst/java folder of this repository, or use Maven as described above. Run this from the command line to get a list of options:
```
java -jar SQLCon.jar ?
```

User Documentation
==================
* Vignette: [Using SQLCon](https://kganilkg131.github.io/SQLCon/articles/UsingSQLCon.html)
* Package manual: [SQLCon manual](https://kganilkg131.github.io/SQLCon/reference/index.html) 

Support
=======
* Developer questions/comments/feedback: <a href="http://forums.ohdsi.org/c/developers">OHDSI Forum</a>
* We use the <a href="https://github.com/kganilkg131/SQLCon/issues">GitHub issue tracker</a> for all bugs/issues/enhancements

License
=======


Development
===========
SQLCon is being developed in R Studio.

### Development status

Stable. The code is actively being used in several projects.

Acknowledgements
================
- This project is supported in part through the National Science Foundation grant IIS 1251151.
