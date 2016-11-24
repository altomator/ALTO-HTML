<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 sp1 (http://www.altova.com) by BnF (BNF) -->

<!--Auteur  : BnF/DSR/DSC/NUM/JP Moreux, Version : 1.0 -->
<!-- To be used with Xalan-Java -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
 xmlns:alto="http://www.loc.gov/standards/alto/ns-v3#"
 xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">


<xsl:output method="html" indent="no" omit-xml-declaration="yes"/>
	
<xsl:template match="/">
      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
      <xsl:text disable-output-escaping='yes'>&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;</xsl:text>
      <head>
         <xsl:text disable-output-escaping='yes'>&lt;meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/&gt;</xsl:text>      
         <xsl:text disable-output-escaping='yes'>&lt;link rel="stylesheet" href="..\..\..\CSS\stylesheet.css" type="text/css"/&gt;</xsl:text>
         
         <title>Affichage des contenus ALTO</title> 
   </head>
   <body>
     <xsl:apply-templates select="/alto:alto/alto:Layout/alto:Page"/>
     <hr/>
     
  </body>
      <xsl:text disable-output-escaping='yes'>&lt;/html&gt;</xsl:text>
</xsl:template>

<!-- Traitement des tags   
<xsl:template match="alto:Tags">
      <p class="comment">TAGS</p>
      <p class="comment"><a><xsl:attribute name="id"><xsl:value-of select="attribute::ID"/></xsl:attribute></a><xsl:value-of select="@ID"/>: <xsl:value-of select="@TYPE"/> /   <xsl:value-of select="@LABEL"/></p>
</xsl:template> -->

<!-- Traitement des pages   -->
<xsl:template match="alto:Page">
   <xsl:apply-templates/>
</xsl:template>



<!-- Text -->
<xsl:template match="alto:TextBlock">
 <!-- -b:<xsl:value-of   select="count(child::*)"/>-  -->
     <xsl:variable name="childLines" select="child::*"/>
<xsl:choose>
        <!-- tag ?  -->
        <xsl:when test="@TAGREFS">  
            <xsl:text disable-output-escaping='yes'>&lt;p class="TextBlock"&gt;</xsl:text>   
            <xsl:variable name="root" select="/"/>   <!-- we need the root within the for-each loop -->
            
            
            <xsl:for-each select="str:tokenize(@TAGREFS,'\ ')">  <!-- a textblock can have multiple tags -->
				<xsl:variable name="tagID"><xsl:value-of select="."/></xsl:variable> 
           		           			             
				<xsl:apply-templates select="$root/alto:alto/alto:Tags/*[@ID=$tagID]">
					<xsl:with-param name="childs" select="$childLines"/>
				</xsl:apply-templates> 
								
				<!-- add a link on the tag ID  -->
				<xsl:variable name="tagLabel"><xsl:value-of select="$root/alto:alto/alto:Tags/*[@ID=$tagID]/@LABEL"/></xsl:variable>
				<a><xsl:attribute name="href">#<xsl:value-of select="$tagID"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="$tagLabel"/></xsl:attribute>
				<sup class="tagID"><xsl:value-of select="$tagID"/></sup> </a>	 
			</xsl:for-each>	
			<span class="tb">&#167;</span><xsl:text disable-output-escaping='yes'>&lt;/p&gt;</xsl:text>	
		</xsl:when> 
        <xsl:otherwise><p class="TextBlock"><xsl:apply-templates/><span class="tb">&#167;</span></p></xsl:otherwise>
  </xsl:choose>
  
</xsl:template>   


<xsl:template match="alto:TextLine">
   
	<xsl:choose>
        <!-- tag ?  -->
        <xsl:when test="@TAGREFS">
            <xsl:variable name="NextTagID"><xsl:value-of select="following-sibling::alto:TextLine/@TAGREFS"/></xsl:variable> 
            <xsl:variable name="root" select="/"/>   <!-- we need the root within the for-each loop -->
            <xsl:variable name="childStrings" select="child::*"/>
            
            <xsl:for-each select="str:tokenize(@TAGREFS,'\ ')">  <!-- a Line can have multiple tags -->
				<xsl:variable name="tagID"><xsl:value-of select="."/></xsl:variable> 
           		           			             
				<xsl:apply-templates select="$root/alto:alto/alto:Tags/*[@ID=$tagID]">
					<xsl:with-param name="childs" select="$childStrings"/>
				</xsl:apply-templates> 
				
				<!-- add a link on the tag ID  -->
				<xsl:choose>  
					<xsl:when test="$tagID!=$NextTagID">  <!-- do not repeat the tag on multiple tagged lines -->
						<xsl:variable name="tagLabel"><xsl:value-of select="$root/alto:alto/alto:Tags/*[@ID=$tagID]/@LABEL"/></xsl:variable>
						<a><xsl:attribute name="href">#<xsl:value-of select="$tagID"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$tagLabel"/></xsl:attribute>
						<sup class="tagID"><xsl:value-of select="$tagID"/></sup> </a>	</xsl:when> 
				</xsl:choose>	
			</xsl:for-each>			
		</xsl:when>   				
						 
		 <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>	
	</xsl:choose>
			
		 <xsl:if test="following-sibling::alto:TextLine">  <!-- if a line follows, add a CR -->
           <span class="st">&#8629;</span><br/>
         </xsl:if> 
	</xsl:template>
	 
	 
<!-- <xsl:key name="tagParID" match="alto:Tag" use ="@ID" />   -->
<xsl:template match="alto:String">
	
	<xsl:variable name="StringContent"><xsl:value-of select="@CONTENT"/></xsl:variable>
                    
	<xsl:choose>
	<!-- tag exists?  -->
    <xsl:when test="@TAGREFS">	
   	    <xsl:variable name="NextTagID"><xsl:value-of select="following-sibling::alto:String/@TAGREFS"/></xsl:variable>
        <xsl:variable name="root" select="/"/>
                
 	    <xsl:for-each select="str:tokenize(@TAGREFS,'\ ')">  <!-- a String can have multiple tags -->
           	<xsl:variable name="tagID"><xsl:value-of select="."/></xsl:variable> 
            <!-- <xsl:variable name="tagType"><xsl:value-of select="test"/></xsl:variable>	 
           	 <xsl:variable name="tagType"><xsl:value-of select='key("tagParID", .)/@TYPE'/></xsl:variable> 
			<p class="comment">tagID :<xsl:value-of select="$tagID"/></p>		-->	 
			<!-- <p class="comment">tagType : <xsl:value-of select="$tagType"/></p>   -->
				
	        <xsl:apply-templates select="$root/alto:alto/alto:Tags/*[@ID=$tagID]">
					<xsl:with-param name="content" select="$StringContent"/>
			 </xsl:apply-templates>
	
			<!-- add a link on the tag ID  
			<p class="comment">Next : <xsl:value-of select="$NextTagID"/></p> -->
			<xsl:choose>  
					<xsl:when test="$tagID!=$NextTagID"> <!-- do not repeat the tag on multiple tagged strings -->
						<xsl:variable name="tagLabel"><xsl:value-of select="$root/alto:alto/alto:Tags/*[@ID=$tagID]/@LABEL"/></xsl:variable>
						<a><xsl:attribute name="href">#<xsl:value-of select="$tagID"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$tagLabel"/></xsl:attribute>
						<sup class="tagID"><xsl:value-of select="$tagID"/></sup> </a></xsl:when>	
				</xsl:choose>	
			 </xsl:for-each>			
			</xsl:when>   
			
			<!-- no tag  -->				
			<xsl:otherwise><xsl:value-of select="$StringContent"/><xsl:text disable-output-escaping='yes'>&#x20;</xsl:text></xsl:otherwise>
		</xsl:choose>
  </xsl:template>
	
	
<xsl:template match="alto:NamedEntityTag">	
	<xsl:param name="content" />
 
    <xsl:variable name="NEType"><xsl:value-of select="./@TYPE"/></xsl:variable>
	<!-- <p class="comment">NE/tagType : <xsl:value-of select="$NEType"/></p>  -->
	 <xsl:text disable-output-escaping='yes'>&lt;span class="tagNEContent </xsl:text>   
	
	<xsl:choose>
		<!-- various NE  -->
		 <xsl:when test="$NEType='Person'"><xsl:text disable-output-escaping='yes'>tagNEPContent"&gt;</xsl:text></xsl:when>
		 <xsl:when test="$NEType='Location'"><xsl:text disable-output-escaping='yes'>tagNELContent"&gt;</xsl:text></xsl:when> 
		 <xsl:when test="$NEType='Organization'"><xsl:text disable-output-escaping='yes'>tagNEOContent"&gt;</xsl:text></xsl:when>
	     <xsl:otherwise><xsl:text disable-output-escaping='yes'>"&gt;</xsl:text><sup class="tagID">unknown NE type:<xsl:value-of select="$NEType"/></sup></xsl:otherwise>
	</xsl:choose>
	<xsl:value-of select="$content"/><xsl:text disable-output-escaping='yes'>&lt;/span&gt;</xsl:text>		
</xsl:template>  

	 
<xsl:template match="alto:StructureTag">
     <xsl:param name="childs"/>
        
	<!--<p class="comment">Structure : <xsl:value-of select="./@LABEL"/></p> -->
	<span class="tagStructureContent"><xsl:apply-templates select="$childs"/></span>
</xsl:template>  

<xsl:template match="alto:LayoutTag">
    <xsl:param name="childs" />	
    
	<!--<p class="comment">Layout : <xsl:value-of select="./@LABEL"/></p> -->
	<span class="tagLayoutContent"><xsl:apply-templates select="$childs"/></span>
</xsl:template>  
  	
<xsl:template match="alto:RoleTag">	
	<xsl:param name="childs" />
	
	<span class="tagRoleContent"><xsl:apply-templates select="$childs"/></span>
</xsl:template>  

<xsl:template match="alto:OtherTag">	
	<xsl:param name="childs" />
	
	<span class="tagOtherContent"><xsl:apply-templates select="$childs"/></span>
</xsl:template>  
  	
  	
  	
<!-- Graphical blocks  -->
<xsl:template match="alto:GraphicalElement">
      <!-- Traitement des types de bloc  -->
      
      <p class="GraphicalElement"><span class="ge">GE</span></p>
  </xsl:template>    
    
<!-- Illustration  -->
<xsl:template match="alto:Illustration">
    
      <p class="Illustration"> Ill </p>
           
  </xsl:template>    
  
 <!-- Composed blocks  -->
<xsl:template match="alto:ComposedBlock">
    <p class="ComposedBlockDebut"><span class="cb">CB {</span></p>
     <xsl:apply-templates />
    <p class="ComposedBlockFin"><span class="cb">} CB</span></p>
           
  </xsl:template>      
       

</xsl:stylesheet>
