<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
	 <xsl:output method="text" encoding="UTF-8" media-type="text/plain"/>
	<xsl:variable name="dictionary" select="document('acord-data-dictionary.xml')"/>
	<xsl:param name="requestMessage">ClaimsNotificationAddRq</xsl:param>
	<xsl:param name="responseMessage">ClaimsNotificationAddRs</xsl:param>
	<xsl:key name="tag" match="ACORD-XML-DOC/Tags/Tag" use="@id"/>
	<xsl:key name="dataType" match="ACORD-XML-DOC/DataTypes/DataType" use="@id"/>
	<xsl:key name="attribute" match="ACORD-XML-DOC/AttributeInfo/AttributeInfo" use="@id"/>
	<xsl:key name="usage" match="ACORD-XML-DOC/Usages/TagUsage" use="@idref"/>
	
<xsl:template match="/">
<xsl:variable name="definitions"><xsl:apply-templates select="/ACORD-XML-DOC/Tags/Tag"/></xsl:variable>
<xsl:variable name="json_definitions">
	<xsl:call-template name="strip-end-characters">
		<xsl:with-param name="text" select="$definitions"/>
		<xsl:with-param name="strip-count" select="1"/>
	</xsl:call-template>
</xsl:variable>
{"swagger":"2.0",
 "info":{
 	"description":"ACORD API Documentation",
	"version":"2.0.0",
	"title":"ACORD API",
	"termsOfService":"acord.org/terms",
	"contact":{"email":"beilakj@acord.org"},
	"license":{
		"name":"ACORD Licence",
		"url":"http://www.acord.org"
		}
	},
 "host":"www.acord.org",
 "basePath":"/api/v2",
 "tags":[ 		
 	{"name":"policy","description":"Access everything about a policy","externalDocs":{"description":"Find out more","url":"http://demo.goodville.com/docs/policy"}},
	{"name":"claim","description":"Access everything about a claim"},
	{"name":"agent","description":"Access information about our agents","externalDocs":{"description":"Find out more about our store","url":"http://demo.goodville.com/docs/agents"}}
	],
"schemes":["http"],
"paths":{
"/policy":{
			"post":{
				"tags":["Policy"],
				"summary":"Policy Request",
				"description":"This message expresses a policy Request",
				"operationId":"PolicyRq",
				"consumes":["application/xml","application/json"],
				"produces":["application/xml","application/json"],
				"parameters":[{"in":"body","name":"body","description":"XML for looking up a policy","required":true,"schema":{"$ref":"#/definitions/PolicyRq"}}],
				"responses":{
					"200":{"description":"successful operation","schema":{"$ref":"#/definitions/PolicyRs"}},
					"400":{"description":"Invalid Order"}}}
		},
"/claim":{
			"post":{
				"tags":["claim"],
				"summary":"Claim Notification Add Request",
				"description":"This message submits the first notice of loss and accompanying claims attachments.",
				"operationId":"ClaimNotificationAddRq",
				"consumes":["application/xml","application/json"],
				"produces":["application/xml","application/json"],
				"parameters":[{"in":"body","name":"body","description":"XML Content for reporting a loss","required":true,"schema":{"$ref":"#/definitions/ClaimsNotificationAddRq"}}],
				"responses":{
					"200":{"description":"successful operation","schema":{"$ref":"#/definitions/ClaimsNotificationAddRs"}},
					"400":{"description":"Invalid Order"}}}
		}
	},
"definitions":{<xsl:value-of select="$json_definitions"/>},
"externalDocs":{"description":"Find more about ACORD","url":"http://www.acord.org/"}
}
	</xsl:template>
<xsl:template match="/ACORD-XML-DOC/Tags/Tag">
	<xsl:variable name="tag"  select="key('tag',@id)" />
	<xsl:variable name="tagName" select="$tag/TagName"/>
	<xsl:variable name="tagType" select="$tag/@type"/>
	<xsl:variable name="json"><xsl:choose>
			<xsl:when test="$tagType = 'Entity'">
				<xsl:call-template name="renderElement">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$tagType ='Aggregate'">
				<xsl:call-template name="renderElement">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$tagType = 'Message'">
				<xsl:call-template name="renderMessages">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$tagType = 'DocumentRoot'">
				<xsl:call-template name="renderDocumentRoot">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$tagType = 'Service'">
				<xsl:call-template name="renderElement">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$tagType = 'Element'">
				<xsl:call-template name="renderElement">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="renderMessages">
					<xsl:with-param name="tag" select="$tag"/>
				</xsl:call-template></xsl:otherwise>
		</xsl:choose></xsl:variable>
	<xsl:value-of select="$json"/>	
</xsl:template>

<xsl:template name="renderDocumentRoot">
	<xsl:param name="tag"/>
	<xsl:variable name="id" select="$tag/@id"/>
	<xsl:variable name="dataTypeObj" select="key('dataType',$tag/BaseClassName/@baseclassref)"/>
	<xsl:variable name="jsonDataTypeRef">
		<xsl:call-template name="json-baseclass">
			<xsl:with-param name="dataType" select="$dataTypeObj" />
			<xsl:with-param name="kind">Reference</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<!-- <Tag id="ACORD" type="DocumentRoot" deprecated="No">
      <TagName>ACORD</TagName>
      <TagTitle>ACORD Aggregate</TagTitle>
      <Desc>
        <p>An ACORD Document is a collection of services and messages sent as a single unit between client and server. Note that both the request document and the response document share the <el ref="ACORD">ACORD</el> tag name.</p>
<note><p>FRAMEWORK NOTE This data item may not apply if the implementation is utilizing ACORD's AWSP (ACORD Web Services Profile) documentation. Omission of this item does not automatically assume all related child content (if applicable) no longer applies. Refer to the Framework section of this standard, specifically the Introduction of that section as well as the AWSP documentation for details. </p></note></Desc>
      <Service>Framework</Service>
      <Category>Common</Category>
      <BaseClassName baseclassref="ACORD_Type" />
    </Tag>
	<DataType id="ACORD_Type" deprecated="No">
      <TypeName>ACORD_Type</TypeName>
      <TypeTitle>ACORD Type</TypeTitle>
      <Desc>
        <p>An ACORD Document is a collection of services and messages sent as a single unit between client and server. Note that both the request document and the response document share the <el ref="ACORD">ACORD</el> tag name.</p>
      </Desc>
      <BaseClass>
        <Group logicflag="XOR" required="Yes" repeating="No">
          <Content idref="ACORDREQ" required="Yes" repeating="No" logicflag="XOR" echoed="No" deprecated="No" seeDesc="No" />
          <Content idref="ACORDRSP" required="Yes" repeating="No" logicflag="XOR" echoed="No" deprecated="No" seeDesc="No" />
        </Group>
      </BaseClass>
    </DataType>-->
	<xsl:variable name="json">"<xsl:value-of select="$tag/TagName"/>":{"type":"object","format":"<xsl:value-of select="$tag/BaseClassName/@baseclassref"/>","description":"","xml":{},"properties":{<xsl:value-of select="$jsonDataTypeRef"/>}},</xsl:variable>
	<xsl:value-of select="$json"/>
</xsl:template>
<xsl:template name="renderMessages">
	<xsl:param name="tag"/>
	<xsl:variable name="id" select="$tag/@id"/>
	<xsl:variable name="dataTypeObj" select="key('dataType',$tag/BaseClassName/@baseclassref)"/>
	<xsl:variable name="jsonDataTypeRef">
		<xsl:call-template name="json-baseclass">
			<xsl:with-param name="dataType" select="$dataTypeObj" />
			<xsl:with-param name="kind">Reference</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="json">"<xsl:value-of select="$tag/TagName"/>":{"type":"object","format":"<xsl:value-of select="$tag/BaseClassName/@baseclassref"/>","description":"","xml":{},"properties":{<xsl:value-of select="$jsonDataTypeRef"/>}},</xsl:variable>
	<xsl:value-of select="$json"/>
</xsl:template>
<xsl:template name="renderElement">
	<xsl:param name="tag"/>
	<xsl:variable name="id" select="$tag/@id"/>
	<xsl:variable name="dataTypeObj" select="key('dataType',$tag/BaseClassName/@baseclassref)"/>
	<xsl:variable name="jsonDataTypeRef">
		<xsl:call-template name="json-baseclass">
			<xsl:with-param name="dataType" select="$dataTypeObj" />
			<xsl:with-param name="kind">Normal</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="json">"<xsl:value-of select="$tag/TagName"/>":{"type":"object","format":"<xsl:value-of select="$tag/BaseClassName/@baseclassref"/>","description":"","xml":{},"properties":{<xsl:value-of select="$jsonDataTypeRef"/>}},</xsl:variable>
	<xsl:value-of select="$json"/>
</xsl:template>
<xsl:template name="json-baseclass">
	<xsl:param name="dataType"/>
	<xsl:param name="kind"/>
	<xsl:variable name="json-attributes">
		<xsl:call-template name="json-baseclass-attributes">
			<xsl:with-param name="attributes" select="$dataType/BaseClass/Attributes"/>
			<xsl:with-param name="kind" select="$kind"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="json-groups">
		<xsl:call-template name="json-baseclass-group">
			<xsl:with-param name="group" select="$dataType/BaseClass/Group"/>
			<xsl:with-param name="kind" select="$kind"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:call-template name="add-json-params">
		<xsl:with-param name="one" select="$json-attributes"/>
		<xsl:with-param name="two" select="$json-groups"/>
		<xsl:with-param name="separator">,</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="json-baseclass-attributes">
	<xsl:param name="attributes"/>
	<xsl:param name="kind"/>
	<xsl:if test="count($attributes/Attribute) > 0">
		<xsl:for-each select="$attributes/Attribute">"<xsl:value-of select="@idref" />":{"type":"string","description":"","xml":{"attribute":true}}<xsl:if test="position() &lt; last()">,</xsl:if></xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="json-baseclass-group">
	<xsl:param name="group"/>
	<xsl:param name="kind"/>
	<xsl:variable name="json">
		<xsl:if test="count($group/Content) > 0">
			<xsl:for-each select="$group/Content">
				<xsl:variable name="tag" select="key('tag',@idref)"/>
				<xsl:variable name="type" select="$tag/@type"/>
				<xsl:variable name="jsonType">
					<xsl:call-template name="json-obj-data-type">
						<xsl:with-param name="name" >object</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="usage-json">
					<xsl:call-template name="json-usage">
						<xsl:with-param name="id" select="@idref"/>
						<xsl:with-param name="kind" select="$kind"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$kind = 'Reference'">
						<xsl:if test="$type != 'Entity'">"<xsl:value-of select="@idref"/>":{"$ref":"#/definitions/<xsl:value-of select="@idref"/>"},</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$type != 'Entity'">"<xsl:value-of select="@idref"/>":{<xsl:value-of select="$jsonType"/>,"description":"","properties":{<xsl:value-of select="$usage-json"/>}},</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$type = 'Entity'"><xsl:value-of select="$usage-json"/>,</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:variable>
	<xsl:call-template name="strip-end-characters">
       <xsl:with-param name="text" select="$json" />
	   <xsl:with-param name="strip-count">1</xsl:with-param>
	</xsl:call-template>		
</xsl:template>
<xsl:template name="json-usage">
	<xsl:param name="id"/>
	<xsl:param name="kind"/>
	<xsl:variable name="usage" select="key('usage',$id)"/>
	<xsl:variable name="json-attributes">
		<xsl:call-template name="json-baseclass-attributes">
			<xsl:with-param name="attributes" select="$usage/Attributes"/>
			<xsl:with-param name="kind" select="$kind"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="json-groups">
		<xsl:call-template name="json-baseclass-group">
			<xsl:with-param name="group" select="$usage/Group"/>
			<xsl:with-param name="kind" select="$kind"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:call-template name="add-json-params">
		<xsl:with-param name="one" select="$json-attributes"/>
		<xsl:with-param name="two" select="$json-groups"/>
		<xsl:with-param name="separator">,</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- Helper functions-->
<xsl:template name="json-obj-base-type">
	<xsl:param name="name"/>
	<xsl:choose>
		<xsl:when test="$name = 'boolean'">"type":"boolean"</xsl:when>
		<xsl:when test="$name =' '">"type":"string"</xsl:when>
		<xsl:when test="$name='object'">"type":"object"</xsl:when>
		<xsl:otherwise>"type":"string","format":"<xsl:value-of select="$name"/>"</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template name="json-obj-data-type">
	<xsl:param name="name"/>
	<xsl:choose>
		<xsl:when test="$name = 'boolean'">"type":"boolean"</xsl:when>
		<xsl:when test="string-length(replace($name, '^\s+|\s+$', '')) > 0">"type":"string"</xsl:when>
		<xsl:when test="$name='object'">"type":"object"</xsl:when>
		<xsl:otherwise>"type":"string","format":"<xsl:value-of select="$name"/>"</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template name="strip-end-characters">
    <xsl:param name="text"/>
    <xsl:param name="strip-count"/>
    <xsl:value-of select="substring($text, 1, string-length($text) - $strip-count)"/>
 </xsl:template>
<xsl:template name="add-json-params">
	<xsl:param name="one"/>
	<xsl:param name="two"/>
	<xsl:param name="separator"/>
	<xsl:if test="((string-length(replace($one, '^\s+|\s+$', '')) > 0) and (string-length(replace($two, '^\s+|\s+$', ''))>0))"><xsl:value-of select="replace($one, '^\s+|\s+$', '')"/><xsl:value-of select="$separator"/><xsl:value-of select="replace($two, '^\s+|\s+$', '')"/></xsl:if>
	<xsl:if test="((string-length(replace($one, '^\s+|\s+$', '')) = 0) or (string-length(replace($two, '^\s+|\s+$', ''))=0))"><xsl:value-of select="replace($one, '^\s+|\s+$', '')"/><xsl:value-of select="replace($two, '^\s+|\s+$', '')"/></xsl:if>
</xsl:template>

</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="XML 2.0 MetaData.xml" htmlbaseurl="" outputurl="file:///c:/lucee/webapps/ROOT/swagger-ui-master/dist/acordSwagger.json" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="XML 2.0 MetaData.xml" srcSchemaRoot="ACORD-XML-DOC" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
			<SourceSchema srcSchemaPath="acord-data-dictionary.xml" srcSchemaRoot="" AssociatedInstance="file:///e:/Documents/Dropbox/ACORD/work in progress/ACORD Transforms/acord-data-dictionary.xml" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->