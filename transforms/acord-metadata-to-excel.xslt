<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
						xmlns="urn:schemas-microsoft-com:office:spreadsheet"
						 xmlns:o="urn:schemas-microsoft-com:office:office"
						 xmlns:x="urn:schemas-microsoft-com:office:excel"
						 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
						 xmlns:html="http://www.w3.org/TR/REC-html40" >
						 
	<xsl:output method="xml" version="1.0" media-type="text/xml" encoding="iso-8859-1" indent="yes"/>

	<xsl:template match="/ACORD-XML-DOC">
		<Workbook>
			<Worksheet ss:Name="tag">
				<xsl:call-template name="tag-table" />
			</Worksheet>
			<Worksheet ss:Name="data">
				<xsl:call-template name="data-table" />
			</Worksheet>
			<Worksheet ss:Name="option">
				<xsl:call-template name="option-table" />
			</Worksheet>
			<Worksheet ss:Name="attribute">
				<xsl:call-template name="attribute-table" />
			</Worksheet>
			<Worksheet ss:Name="usage">
				<xsl:call-template name="usage-table" />
			</Worksheet>
		</Workbook>
	</xsl:template>
	
  <xsl:template name="tag-table">  
		<Table ss:ExpandedColumnCount="6" ss:ExpandedRowCount="{count(Tags/Tag)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">TAG_ID</Data></Cell>
			<Cell><Data ss:Type="String">TAG_NAME</Data></Cell>
			<Cell><Data ss:Type="String">TAG_TYPE</Data></Cell>
			<Cell><Data ss:Type="String">TAG_DESC</Data></Cell>
			<Cell><Data ss:Type="String">TAG_DATA</Data></Cell>
			<Cell><Data ss:Type="String">TAG_OLD</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="Tags/Tag">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="TagName" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@type" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Desc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="DataTypeName/@datatyperef" /><xsl:value-of select="BaseClassName/@baseclassref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>       
        
	  </Table>   
  </xsl:template>
		
  <xsl:template name="data-table">
		<Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="{count(DataTypes/DataType)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">DATA_ID</Data></Cell>
			<Cell><Data ss:Type="String">DATA_NAME</Data></Cell>
			<Cell><Data ss:Type="String">DATA_DESC</Data></Cell>
			<Cell><Data ss:Type="String">DATA_TYPE</Data></Cell>
			<Cell><Data ss:Type="String">DATA_BASE</Data></Cell>
			<Cell><Data ss:Type="String">DATA_LENGTH</Data></Cell>
			<Cell><Data ss:Type="String">DATA_FORMAT</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="DataTypes/DataType">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="TypeTitle" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Desc" /></Data></Cell>
			<Cell><Data ss:Type="String">        
				<xsl:choose>
					<xsl:when test="Restriction">Restriction</xsl:when>
					<xsl:when test="Extension">Extension</xsl:when>
					<xsl:when test="BaseClass">BaseClass</xsl:when>
					<xsl:when test="Union">Union</xsl:when>
					<xsl:when test="Enumeration">Enumeration</xsl:when>
					<xsl:otherwise>Unknown</xsl:otherwise>
				</xsl:choose>
			</Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="*/BaseType/@type" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="*/MaxLength" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="*/Pattern" /></Data></Cell>
		   </Row>
        </xsl:for-each>       
        
	  </Table>   
  </xsl:template>
	
  <xsl:template name="option-table">
		<Table ss:ExpandedColumnCount="4" ss:ExpandedRowCount="{count(DataTypes/DataType/Enumeration/Codes/Code)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">OPTION_DATA</Data></Cell>
			<Cell><Data ss:Type="String">OPTION_VALUE</Data></Cell>
			<Cell><Data ss:Type="String">OPTION_DESC</Data></Cell>
			<Cell><Data ss:Type="String">TAG_DATA</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="DataTypes/DataType/Enumeration/Codes/Code">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="../../../TypeName" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Value" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Desc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>       
        
	  </Table>         
  </xsl:template>
  
  <xsl:template name="attribute-table">
		<Table ss:ExpandedColumnCount="4" ss:ExpandedRowCount="{count(AttributesInfo/AttributeInfo)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">ATTRIBUTE_NAME</Data></Cell>
			<Cell><Data ss:Type="String">ATTRIBUTE_TYPE</Data></Cell>
			<Cell><Data ss:Type="String">ATTRIBUTE_DESC</Data></Cell>
			<Cell><Data ss:Type="String">ATTRIBUTE_OLD</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="AttributesInfo/AttributeInfo">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@type" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Desc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>       
        
	  </Table>         
  </xsl:template>
	
  <xsl:template name="usage-table">
		<Table ss:ExpandedColumnCount="8" ss:ExpandedRowCount="{count(Usages/TagUsage//Content)+count(DataTypes/DataType//Content)+count(DataTypes/DataType//ReferenceItem)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">USAGE_TYPE</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_PARENT</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_NAME</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_DESC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REQUIRED</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REPEATING</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_LOGIC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_OLD</Data></Cell>
		   </Row>
  
		<!-- groups -->
        <xsl:for-each select="Usages/TagUsage//Content">
		   <Row>
			<Cell><Data ss:Type="String">Group</Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::TagUsage/@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="SupplementalDesc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@required" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@repeating" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@logicflag" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>     
  
		<!-- data tags -->
        <xsl:for-each select="DataTypes/DataType//Content">
		   <Row>
			<Cell><Data ss:Type="String">Tag</Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::DataType/@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="SupplementalDesc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@required" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@repeating" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@logicflag" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>  
  
		<!-- data attributes -->
        <xsl:for-each select="DataTypes/DataType//ReferenceItem">
		   <Row>
			<Cell><Data ss:Type="String">Attribute</Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::DataType/@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::Attribute/@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::Attribute/SupplementalDesc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::Attribute/@required" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::Attribute/@repeating" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@TagIDRef" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::Attribute/@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>     
        
	  </Table>         
  </xsl:template>
  
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///e:/Documents/Dropbox/ACORD/2016-1_Spring_XML_Member_Release Updated/Member/Support Files/XML 2.0 MetaData.xml" htmlbaseurl=""
		          outputurl="file:///e:/Documents/Dropbox/ACORD/work in progress/FNOL Transaction 2.0 Transaction Spec/ACORD2.xls" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->