<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="CL">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="CL"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="PL">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="PL"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="FL">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="FL"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/*[not(contains(local-name(),'ACORD'))]|/ACORD/*[contains(local-name(),'InsuranceSvc')]/*[not(contains(local-name(),'RqUID') or contains(local-name(),'SPName'))]">
		<xsl:variable name="mode">
			<xsl:choose>
				<xsl:when test="*[contains(local-name(),'FarmLineBusiness')]">FL</xsl:when>
				<xsl:when test="*[contains(local-name(),'Pers') and contains(local-name(),'LineBusiness')]">PL</xsl:when>
				<xsl:when test="*[contains(local-name(),'HomeLineBusiness')]">PL</xsl:when>
				<xsl:when test="*[contains(local-name(),'DwellFireLineBusiness')]">PL</xsl:when>
				<xsl:when test="*[contains(local-name(),'WatercraftLineBusiness')]">PL</xsl:when>
				<xsl:otherwise>CL</xsl:otherwise>	
			</xsl:choose>					
		</xsl:variable>
		<xsl:variable name="message">
			<xsl:choose>
				<!-- Package -->
				<xsl:when test="count(*[contains(local-name(),'LineBusiness')]) > 1">
					<xsl:choose>
						<xsl:when test="AircraftLineBusiness or AirportFBOLineBusiness">AviationPkg</xsl:when>
						<xsl:when test="*[contains(local-name(),'PersPkg')]">PersPkg</xsl:when>
						<xsl:otherwise>CommlPkg</xsl:otherwise>	
					</xsl:choose>	
				</xsl:when>
				<!-- Monoline -->
				<xsl:when test="count(*[contains(local-name(),'LineBusiness')]) = 1">
					<xsl:value-of select="substring-before(local-name(*[contains(local-name(),'LineBusiness')][1]),'LineBusiness')" />
				</xsl:when>
				<xsl:otherwise>Policy</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="contains(BusinessPurposeTypeCd,'NBQ')">PolicyQuoteInq</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'NBS')">PolicyAdd</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'PCH')">PolicyMod</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'RIX')">PolicyReissue</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'RWL')">PolicyRenew</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'REI')">PolicyReinstate</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'XLN')">PolicyCancel</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="contains(local-name(),'Notify')">Notify</xsl:when>
				<xsl:when test="contains(local-name(),'NotifyRs')">NotifyRs</xsl:when>
				<xsl:when test="contains(local-name(),'Rq')">Rq</xsl:when>
				<xsl:when test="contains(local-name(),'Rs')">Rs</xsl:when>
				<xsl:otherwise>Msg</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="{$message}">			
			<!-- POLICYRQINFO -->
			<xsl:apply-templates select="RqUID"/>
			<xsl:apply-templates select="ItemIdInfo"/>
			<xsl:apply-templates select="TransactionRequestDt"/>
			<xsl:apply-templates select="TransactionEffectiveDt"/>
			<xsl:apply-templates select="CurCd"/>
			<xsl:apply-templates select="CodeList"/>
			<xsl:apply-templates select="ConversionRate"/>
			<xsl:apply-templates select="BroadLOBCd"/>
			<xsl:apply-templates select="ACORDStandardVersionCd"/>
			<xsl:apply-templates select="PendManualProcessingInd"/>  
			<xsl:apply-templates select="AppetiteRequestInd"/>  
			<xsl:apply-templates select="FormsRequestedCd"/>
			<xsl:apply-templates select="SaveIndicationCd"/> 
			<xsl:apply-templates select="ChangeStatus" />
			<xsl:apply-templates select="ModInfo" /> 
			<xsl:apply-templates select="MsgStatus" /> 
			<xsl:apply-templates select="ResponseURL" /> 
			<xsl:apply-templates select="CancelNonRenewInfo"/>
			<xsl:apply-templates select="ReinstateInfo"/>
			
			<xsl:if test="$mode='PL'">
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="PL" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="PL" />
				<xsl:apply-templates select="Policy" mode="PL"/>
				<xsl:apply-templates select="Location" mode="PL" />
				<xsl:apply-templates select="LocationUWInfo" mode="PL"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="PL"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="PL"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="PL"/>
			</xsl:if>
			
			<xsl:if test="$mode='CL'">
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="CL" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="CL" />
				<xsl:apply-templates select="Policy" mode="CL"/>
				<xsl:apply-templates select="Location" mode="CL" />
				<xsl:apply-templates select="LocationUWInfo" mode="CL"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="CL"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="CL"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="CL"/>
			
			</xsl:if>
			
			<xsl:if test="$mode='FL'">
			
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="FL" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="FL" />
				<xsl:apply-templates select="Policy" mode="FL"/>
				<xsl:apply-templates select="Location" mode="FL" />
				<xsl:apply-templates select="LocationUWInfo" mode="FL"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="FL"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="FL"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="FL"/>
			</xsl:if>
			
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Coverage Aggregates -->
	<xsl:template match="Coverage" mode="PL">
		<xsl:element name="Coverage">
			<xsl:apply-templates select="@*|node()" mode="PL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Coverage" mode="CL">
		<xsl:element name="CommlCoverage">
			<xsl:apply-templates select="@*|node()" mode="CL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Coverage" mode="FL">
		<xsl:element name="CommlCoverage">
			<xsl:apply-templates select="@*|node()" mode="FL"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Policy Aggregates -->
	<xsl:template match="Policy" mode="PL">
		<xsl:element name="PersPolicy">
			<xsl:apply-templates select="@*|node()" mode="PL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="CommlPolicy" mode="CL">
		<xsl:element name="CommlPolicy">
			<xsl:apply-templates select="@*|node()" mode="CL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="FarmRanchPolicy" mode="FL">
		<xsl:element name="FarmRanchPolicy">
			<xsl:apply-templates select="@*|node()" mode="FL"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Driver Aggregates -->
	<xsl:template match="Driver" mode="PL">
		<xsl:element name="PersDriver">
			<xsl:apply-templates select="@*|node()" mode="PL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Driver" mode="CL">
		<xsl:element name="CommlDriver">
			<xsl:apply-templates select="@*|node()" mode="CL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Driver" mode="FL">
		<xsl:element name="CommlDriver">
			<xsl:apply-templates select="@*|node()" mode="FL"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Vehicle Aggregates -->
	<xsl:template match="Vehicle" mode="PL">
		<xsl:element name="PersVeh">
			<xsl:apply-templates select="@*|node()" mode="PL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Vehicle" mode="CL">
		<xsl:element name="CommlVeh">
			<xsl:apply-templates select="@*|node()" mode="CL"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Vehicle" mode="FL">
		<xsl:element name="CommlVeh">
			<xsl:apply-templates select="@*|node()" mode="FL"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse PersVehSupplement Aggregate -->
	<xsl:template match="PersVehSupplement" mode="PL">
		<xsl:apply-templates select="@*|node()" mode="PL"/>
	</xsl:template>
</xsl:stylesheet>


