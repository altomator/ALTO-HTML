# ALTO-HTML
*Conversion of ALTO files (including tags) to HTML*

### Synopsis
Newspapers from European digital librabries collections are part of the data set OLR’ed (Optical Layout Recognition) by the project Europeana Newspapers (www.europeana-newspapers.eu). The OLR refinement consists of the description of the structure of each issue and articles (spatial extent, title and subtitle, classification of content types) using the METS/ALTO formats.

From each digital document is derived a set of bibliographical metadata (date of publication, title) and quantitative metadata related to content and layout (number of pages, articles, words, illustrations, etc.). Shell and XSLT or Perl scripts are used to extract some metadata from METS manifest or from ALTO files.

Detailled presentation: [English](http://altomator.github.io/EN-data_mining/)

### Installation
The script needs xalan-java.

A Sample document is stored in the "DOCS" folder. 


#### XSLT
Two DOS shell scripts :
- ALTO2HTML.bat
- xslt.cmd

One XSLT stylesheet:
- ALTO2HTML.xsl

The XSLT is runned with Xalan-Java. Path to the Java binary must be set in xslt.cmd.
For each document stored in the DOCS folder, all the ALTO files found in the X folder are processed.
The HTML format is generated in a "HTML" folder and rendered with a CSS stylesheet.

##### Test
1. Open a DOS terminal.
2. Change dir to the folder containing the DOCS folder
3. >ALTO2HTML.bat DOCS


