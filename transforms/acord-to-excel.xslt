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
				<xsl:call-template name="tag-body" />
			</Worksheet>
			<Worksheet ss:Name="data">
				<xsl:call-template name="data-body" />
			</Worksheet>
			<Worksheet ss:Name="option">
				<xsl:call-template name="option-body" />
			</Worksheet>
		</Workbook>
	</xsl:template>
	
  <xsl:template name="tag-body">  
		<Table ss:ExpandedColumnCount="4" ss:ExpandedRowCount="{count(Tags/Tag[@type='Element'])+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
		<!-- header -->	   
		   <Row>
			<Cell><Data ss:Type="String">TAG_ID</Data></Cell>
			<Cell><Data ss:Type="String">TAG_NAME</Data></Cell>
			<Cell><Data ss:Type="String">TAG_DESC</Data></Cell>
			<Cell><Data ss:Type="String">TAG_DATA</Data></Cell>
		   </Row>
  
		<!-- body -->
        <xsl:for-each select="Tags/Tag[@type='Element']">
		   <Row>
			<Cell><Data ss:Type="String"><xsl:value-of select="@id" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="TagName" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="Desc" /></Data></Cell>
			<Cell><Data ss:Type="String"><xsl:value-of select="DataTypeName/@datatyperef" /></Data></Cell>
		   </Row>
        </xsl:for-each>       
        
	  </Table>   
  </xsl:template>
		
  <xsl:template name="data-body">
		<Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="{count(DataTypes/DataType[not(Group) and not(BaseClass)])+1}" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
				   
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
        <xsl:for-each select="DataTypes/DataType[not(Group) and not(BaseClass)]">
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
	
  <xsl:template name="option-body">
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
</xsl:stylesheet>

