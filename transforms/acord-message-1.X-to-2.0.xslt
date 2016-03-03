<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/*">
		<PolicyActivityRq>
			
			<!-- POLICYRQINFO -->
			<xsl:apply-templates select="RqUID"/>
			<BusinessPurposeTypeCd>
				<xsl:choose>
					<xsl:when test="contains(local-name(),'Quote')">NBQ</xsl:when>
					<xsl:when test="contains(local-name(),'Add')">NBS</xsl:when>
					<xsl:when test="contains(local-name(),'Mod')">PCH</xsl:when>
					<xsl:when test="contains(local-name(),'Reissue')">RIX</xsl:when>
					<xsl:when test="contains(local-name(),'Renew')">RWL</xsl:when>
					<xsl:when test="contains(local-name(),'Reinstate')">REI</xsl:when>
					<xsl:when test="contains(local-name(),'Cancel')">XLN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</BusinessPurposeTypeCd>
			<xsl:apply-templates select="ItemIdInfo"/>
			<xsl:apply-templates select="TransactionRequestDt"/>
			<xsl:apply-templates select="TransactionEffectiveDt"/>
			<xsl:apply-templates select="CurCd"/>
			<xsl:apply-templates select="CodeList"/>
			<xsl:apply-templates select="ConversionRate"/>
			<xsl:apply-templates select="BroadLOBCd"/>
			<xsl:apply-templates select="ACORDStandardVersionCd"/>
			
			<!-- MR-13-1-28162 for below changes : Add FormsRequestedCd and SaveIndicationCd to the quote request. - Add RiskAppetiteCd, FormsRequestedCd, ResponseURL, and SaveIndicationCd to the quote response .. -->
			<xsl:apply-templates select="PendManualProcessingInd"/>  <!-- TODO : Validate Removal -->
			<xsl:apply-templates select="AppetiteRequestInd"/>  <!-- TODO : Validate Removal - should be BusinessPurposeTypeCd ? -->
			<xsl:apply-templates select="FormsRequestedCd"/> <!-- TODO : Validate Removal -->
			<xsl:apply-templates select="SaveIndicationCd"/> <!-- TODO : Validate Removal -->
			
			<!-- LOB_HEADER -->
			<xsl:apply-templates select="Producer" />
			<xsl:apply-templates select="InsuredOrPrincipal" />
			<xsl:apply-templates select="Policy|PersPolicy|CommlPolicy|FarmRanchPolicy"/>
			<xsl:apply-templates select="Location" />
			<xsl:apply-templates select="ChangeStatus" /> <!-- TODO : Non-Business Aggregate : Move below FOOTER -->
			<xsl:apply-templates select="ModInfo" /> <!-- TODO : Non-Business Aggregate : Move below FOOTER -->
			<xsl:apply-templates select="MsgStatus" /> <!-- TODO : Non-Business Aggregate : Add & Move below FOOTER -->
			<xsl:apply-templates select="ResponseURL" /> <!-- TODO : Non-Business Aggregate : Add & Move below FOOTER -->
			<xsl:apply-templates select="CancelNonRenewInfo"/>
			<xsl:apply-templates select="ReinstateInfo"/>
			
			<!-- LOB_BODY -->
			<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]"/>
			
			<!-- LOB_RQFOOTER -->
			<xsl:apply-templates select="CommlSubLocation"/> <!-- TODO : Move above LOB -->
			<xsl:apply-templates select="RemarkText"/>
			<xsl:apply-templates select="FileAttachmentInfo"/>
		</PolicyActivityRq>
	</xsl:template>
	
	<!-- Collapse Coverage Aggregates -->
	<xsl:template match="PersCoverage|CommlCoverage|LiabilityCoverageLimits">
		<Coverage type="{local-name()}">
			<xsl:apply-templates select="@*|node()"/>
		</Coverage>
	</xsl:template>
	
	<!-- Collapse Policy Aggregates -->
	<xsl:template match="Policy|PersPolicy|CommlPolicy|FarmRanchPolicy">
		<Policy type="{local-name()}">
			<xsl:apply-templates select="@*|node()"/>
			<!-- pull up MiscParty from message -->
			<xsl:apply-templates select="../MiscParty"/>
		</Policy>
	</xsl:template>
</xsl:stylesheet>


