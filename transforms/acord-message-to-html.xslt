<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output media-type="html" indent="yes"/>

	<xsl:variable name="dictionary" select="document('acord-data-dictionary.xml')"/>
	
	<xsl:key name="tag" match="ACORD-XML-DOC/Tags/Tag" use="@id" />
	<xsl:key name="data" match="ACORD-XML-DOC/DataTypes/DataType" use="@id" />
	
	
	<xsl:template match="/">
		<html>
			<head>
				<title>ACORD</title>
			</head>
			<style>
				body {
					color: black;
					font-family: "Avenir", sans-serif;
					font-size: 0.9em;
					line-height: normal;
					background-color: white;
					text-align: left;
				}			
				body, div, h1, h2, h3, h4, h5, h6, img, form, fieldset, blockquote, p {
					border: 0;
					margin: 0;
					padding: 0;
				}
				ul, ol, li, dl, dt, dd {
					margin: 0;
				}
				table {
					border: 0;
					background: #FFFFFF;
					padding: 5px 10px 0px 10px;
					table-layout: fixed;
					width: 100%;
				}
				th, td {
					text-align: left;
					vertical-align: top;
				}
				th {
					border: 1px solid;
				}
				table tr:nth-child(odd) {background: #F3F4F4}
				table tr:nth-child(even) {background: #FFFFFF}
				
				table.closed td {
					display: none;
				}
				table.open td {
					display: default;
				}
				span.help {
					cursor: help;
				}
				th.toggle {
					cursor: pointer;
				}
				
				.fieldImg {
					float: right;
					border: 1px solid;
					padding: 1px;
					margin: 1px;
					cursor: help;
				}
			</style>
			<script type="text/javascript">
				function toggle(id) {
				    var e = document.getElementById(id);
					if(e.className == 'closed') {
						e.className = 'open';
					} else {
						e.className = 'closed';
					}
				}
			</script>

			<body>
				<table cellpadding="0" cellspacing="0">
					<xsl:apply-templates select="*"/>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="*">
		<!-- get tag description -->
		<xsl:variable name="tagdesc">
			<xsl:call-template name="TagDescription">
				<xsl:with-param name="tag" select="name()"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="tagid">
			<xsl:value-of select="generate-id()"/>
		</xsl:variable>
		<!-- aggregate elements -->
		<xsl:if test="descendant::*">
			<tr>
				<td colspan="2">
					<table id="{$tagid}" cellpadding="0" cellspacing="0">
						<tr>
							<th colspan="2" onclick="toggle('{$tagid}')" class="toggle">
								<!-- add anchor -->
								<xsl:if test="@id">
									<a name="{@id}"/>
								</xsl:if>
								<xsl:text> </xsl:text>
								<!-- display name -->
								<span  title="{$tagdesc}" class="help">
									<xsl:call-template name="SplitCamelCase">
										<xsl:with-param name="text" select="name()"/>
									</xsl:call-template>
								</span>
								<!-- display references -->        
								<xsl:for-each select="@*">
									<xsl:if test="substring(name(), string-length(name()) - 2) = 'Ref'">
										<xsl:text> ( </xsl:text>
										<a href="#{.}">
											<xsl:call-template name="SplitCamelCase">
												<xsl:with-param name="text" select="substring(name(), 1, string-length(name()) - 3)"/>
											</xsl:call-template>
										</a>
										<xsl:text> ) </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</th>
						</tr>
						<xsl:apply-templates select="*"/>
					</table>
				</td>
			</tr>
		</xsl:if>
		<!-- leaf elements -->
		<xsl:if test="not(descendant::*)">
			<tr>
				<td>
					<!-- indent -->
					<xsl:text>    </xsl:text>
					<!-- display name -->
					<span  title="{$tagdesc}" class="help">
					<xsl:call-template name="SplitCamelCase">
						<xsl:with-param name="text" select="name()"/>
					</xsl:call-template>
					</span>
				</td>
				<td>
					<!-- display value -->
					<xsl:if test="substring(name(), string-length(name()) - 1) = 'Cd'">
						<xsl:variable name="codedesc">
							<xsl:call-template name="CodeDescription">
								<xsl:with-param name="tag" select="name()"/>
								<xsl:with-param name="code" select="text()"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="not($codedesc = '')">
							<xsl:value-of select="$codedesc"/>
							<xsl:text> (</xsl:text>
							<xsl:value-of select="text()"/>
							<xsl:text>) </xsl:text>
						</xsl:if>
						<xsl:if test="$codedesc = ''">
							<xsl:value-of select="text()"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="not(substring(name(), string-length(name()) - 1) = 'Cd')">
						<xsl:value-of select="text()"/>
					</xsl:if>
					
					<!-- display full xpath - temp. removed 
					<div class="fullPath">
						 <xsl:for-each select="ancestor-or-self::*">

							<xsl:if test="local-name()!='FormServerResponse' and local-name()!='ReturnPayload'  and local-name()!='ACORD' and local-name()!='InsuranceSvcRq' and local-name()!='WorkCompPolicyQuoteInqRq'">

								<xsl:value-of select="concat('.',local-name())"/>
								<xsl:if test="(preceding-sibling::*|following-sibling::*)[local-name()=local-name(current())]">
									<xsl:value-of select="concat('[',count(preceding-sibling::*[local-name()=local-name(current())])+1,']')"/>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</div>
					-->
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="TagDescription">
		<xsl:param name="tag"/>
		<xsl:for-each select="$dictionary">
			<xsl:variable name="desc" select="key('tag',$tag)/Desc/p"/>
			<!-- output description -->
			<xsl:value-of select="$desc"/>
		</xsl:for-each>	
	</xsl:template>
	
	<xsl:template name="CodeDescription">
		<xsl:param name="tag"/>
		<xsl:param name="code"/>
		<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
		<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
		<xsl:for-each select="$dictionary">
			<xsl:variable name="type" select="key('tag',$tag)/DataTypeName/@datatyperef"/>
			<xsl:variable name="desc" select="key('data',$type)/Enumeration/Codes/Code[Value=$code]/Desc/p"/>
			<xsl:if test="$desc and not(translate($desc,$lower,$upper)=translate($code,$lower,$upper))">
				<!-- output description -->
				<xsl:value-of select="$desc"/>
				
			</xsl:if>
		</xsl:for-each>	
	</xsl:template>
	
	<xsl:template name="SplitCamelCase">
		<xsl:param name="text"/>
		<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
		<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
		<xsl:variable name="digits">0123456789</xsl:variable>
		<xsl:if test="$text != ''">
			<xsl:variable name="letter" select="substring($text, 1, 1)"/>
			<xsl:variable name="next" select="substring($text, 2, 1)"/>
			<xsl:choose>
				<xsl:when test="contains($upper, $letter) and not(contains($upper, $next))">
					<xsl:value-of select="concat(' ',$letter)"/>
				</xsl:when>
				<xsl:when test="contains($digits, $letter)">
					<xsl:value-of select="concat(' ',$letter)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$letter"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="SplitCamelCase">
				<xsl:with-param name="text" select="substring-after($text, $letter)"/>
				<xsl:with-param name="digitsMode" select="contains($digits, $letter)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
