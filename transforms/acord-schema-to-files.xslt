<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<xsl:output indent="yes" method="xml" />
	<xsl:template match="/">
	
		<!--
			Split SDP generated schema into componentized files:
				- messages
				- aggregates
				- aggregate extensions (TBD)
				- entities ? (TBD)
				- elements ? (TBD)
				- code lists
				- code list extensions (TBD)
		-->
	
	
		<xsl:result-document href="XML-2.0-Draft-messages.xsd">
			<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.ACORD.org/standards/PC/ACORD2/xml/" targetNamespace="http://www.ACORD.org/standards/PC/ACORD2/xml/" elementFormDefault="unqualified" attributeFormDefault="unqualified" version="2.0-Draft">
					<xsd:annotation>		
						<xsd:documentation>This ACORD schema contains all the messages and should be the last to import other schemas.</xsd:documentation>
						<xsd:appinfo>
							<version>2.0-Draft</version>
							<status>Draft</status>
							<genDate>Thu Mar 03 12:28:22 2016</genDate>
						</xsd:appinfo>
					</xsd:annotation>
					<xsd:include schemaLocation="XML-2.0-Draft-aggregates.xsd" />
					
					<xsl:for-each select="*/*[ends-with(@name,'Rq_Type')
												 or ends-with(@name,'Rs_Type')
												 or ends-with(@name,'Notify_Type')
												 or ends-with(@name,'Rq')
												 or ends-with(@name,'Rs')
												 or ends-with(@name,'Notify')
												 or ends-with(@name,'MSGS')
												 or ends-with(@name,'RS_CHOICE')
												 or ends-with(@name,'RQ_CHOICE')
												 or ends-with(@name,'ACORD')
												 or ends-with(@name,'ACORD_Type')
												 or ends-with(@name,'ACORDREQ')
												 or ends-with(@name,'ACORDRSP')]">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</xsd:schema>
		</xsl:result-document>
		
		
		<xsl:result-document href="XML-2.0-Draft-nocodes.xsd">
			<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.ACORD.org/standards/PC/ACORD2/xml/" targetNamespace="http://www.ACORD.org/standards/PC/ACORD2/xml/" elementFormDefault="unqualified" attributeFormDefault="unqualified" version="2.0-Draft">
				<xsd:annotation>
					<xsd:documentation>This ACORD schema contains all code lists and enumerations.</xsd:documentation>
					<xsd:appinfo>
						<version>2.0-Draft</version>
						<status>Draft</status>
						<genDate>Thu Mar 03 12:28:22 2016</genDate>
					</xsd:appinfo>
				</xsd:annotation>
				<xsd:include schemaLocation="XML-2.0-Draft-basetypes.xsd"/>
				
				<xsl:for-each select="*/*[*/@base='Enumeration_Type']">
					<xsl:copy>
						<xsl:copy-of select="@*"/>
						<xsd:restriction base="Enumeration_Type" />
					</xsl:copy>
				</xsl:for-each>
			</xsd:schema>
		</xsl:result-document>
		
		
		<xsl:result-document href="XML-2.0-Draft-codes.xsd">
			<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.ACORD.org/standards/PC/ACORD2/xml/" targetNamespace="http://www.ACORD.org/standards/PC/ACORD2/xml/" elementFormDefault="unqualified" attributeFormDefault="unqualified" version="2.0-Draft">
				<xsd:annotation>
					<xsd:documentation>This ACORD schema contains all code lists and enumerations.</xsd:documentation>
					<xsd:appinfo>
						<version>2.0-Draft</version>
						<status>Draft</status>
						<genDate>Thu Mar 03 12:28:22 2016</genDate>
					</xsd:appinfo>
				</xsd:annotation>
				<xsd:include schemaLocation="XML-2.0-Draft-basetypes.xsd"/>
				
				<xsl:for-each select="*/*[*/@base='Enumeration_Type']">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</xsd:schema>
		</xsl:result-document>


		<xsl:result-document href="XML-2.0-Draft-basetypes.xsd">
			<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.ACORD.org/standards/PC/ACORD2/xml/" targetNamespace="http://www.ACORD.org/standards/PC/ACORD2/xml/" elementFormDefault="unqualified" attributeFormDefault="unqualified" version="2.0-Draft">
				<xsd:annotation>
					<xsd:appinfo>
						<version>2.0-Draft</version>
						<status>Draft</status>
						<genDate>Thu Mar 03 12:28:22 2016</genDate>
					</xsd:appinfo>
				</xsd:annotation>
				<xsd:import namespace="http://www.w3.org/XML/1998/namespace" schemaLocation="xml-ns.xsd" />
				
				<xsl:for-each select="*/*[(ends-with(@name,'NoID') and name()='xsd:simpleType') or contains(*/@base,'xsd:') ]">
					<xsl:copy-of select="."/>
				</xsl:for-each>
				<xsl:for-each select="*/*[xsd:simpleContent and not(*/@base='Enumeration_Type')]">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</xsd:schema>
		</xsl:result-document>


		<xsl:result-document href="XML-2.0-Draft-aggregates.xsd">
			<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.ACORD.org/standards/PC/ACORD2/xml/" targetNamespace="http://www.ACORD.org/standards/PC/ACORD2/xml/" elementFormDefault="unqualified" attributeFormDefault="unqualified" version="2.0-Draft">
				<xsd:annotation>
					<xsd:appinfo>
						<version>2.0-Draft</version>
						<status>Draft</status>
						<genDate>Thu Mar 03 12:28:22 2016</genDate>
					</xsd:appinfo>
				</xsd:annotation>
				<xsd:include schemaLocation="XML-2.0-Draft-codes.xsd" />
				
				<xsl:for-each select="*/*[not(ends-with(@name,'Rq_Type')
												 or ends-with(@name,'Rs_Type')
												 or ends-with(@name,'Notify_Type')
												 or ends-with(@name,'Rq')
												 or ends-with(@name,'Rs')
												 or ends-with(@name,'Notify')
												 or ends-with(@name,'MSGS')
												 or ends-with(@name,'RS_CHOICE')
												 or ends-with(@name,'RQ_CHOICE')
												 or ends-with(@name,'ACORD')
												 or ends-with(@name,'ACORD_Type')
												 or ends-with(@name,'ACORDREQ')
												 or ends-with(@name,'ACORDRSP'))
												and not(*/@base='Enumeration_Type')
												and not((ends-with(@name,'NoID') and name()='xsd:simpleType') or contains(*/@base,'xsd:'))
												and not(xsd:simpleContent and not(*/@base='Enumeration_Type'))]">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</xsd:schema>
		</xsl:result-document>
		
		
	</xsl:template>
</xsl:stylesheet>
