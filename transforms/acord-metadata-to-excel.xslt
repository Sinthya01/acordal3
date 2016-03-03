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
		<Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="{count(Usages/TagUsage//Content)+count(DataTypes/DataType//Content)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">USAGE_PARENT</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_TAG</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_DESC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REQUIRED</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REPEATING</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_LOGIC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_OLD</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="Usages/TagUsage//Content">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::TagUsage/@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="SupplementalDesc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@required" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@repeating" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@logicflag" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>     
  
		<!-- body -->
        <xsl:for-each select="DataTypes/DataType//Content">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="ancestor::DataType/@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@idref" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="SupplementalDesc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@required" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@repeating" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@logicflag" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="@deprecated" /></Data></Cell>
		   </Row>
        </xsl:for-each>     
        
	  </Table>         
  </xsl:template>
	
  <xsl:template name="content-table">
		<Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="{count(DataTypes/DataType//Content)+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">USAGE_PARENT</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_TAG</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_DESC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REQUIRED</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_REPEATING</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_LOGIC</Data></Cell>
			<Cell><Data ss:Type="String">USAGE_OLD</Data></Cell>
		   </Row>    
        
	  </Table>         
  </xsl:template>
  
</xsl:stylesheet>

