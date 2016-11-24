# ALTO-HTML
*Conversion of ALTO files (including tags) to HTML*

### Synopsis
This script converts ALTO files (version 3.0 or higher) to HTML.
It also renders the tags (logical, layout, semantic, etc.) which were introduced in ALTO v2.1 format. 
See https://www.loc.gov/standards/alto/


### Installation
The script needs xalan-java.

A sample document is stored in the "DOCS" folder. 


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


