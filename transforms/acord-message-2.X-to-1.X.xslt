<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="Comml">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="Comml"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="Pers">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="Pers"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()" mode="FarmRanch">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="FarmRanch"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/*[not(contains(local-name(),'ACORD'))]|/ACORD/*[contains(local-name(),'InsuranceSvc')]/*[not(contains(local-name(),'RqUID') or contains(local-name(),'SPName'))]">
		<xsl:variable name="mode">
			<xsl:choose>
				<xsl:when test="contains(Policy/LOBCd,'AIRC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AIRPFB')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AVPKG')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BANDM')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BOP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AUTOB')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'INMRC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CPKGE')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PROP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'UMBRC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CRIM')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CYBER')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'DO')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'DFIRE')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EPLI')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EO')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CFRM')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CGL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HANG')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HOME')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AUTOP')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'INMRP')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PPKGE')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'UMBRP')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BOAT')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'WORK')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'ACCT')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'ACHE')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AGENT')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AGLIA')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AGPP')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AGPR')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'APKGE')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'APROD')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'ARCH')">Comml</xsl:when>
<!-- 				<xsl:when test="contains(Policy/LOBCd,'AUTO')"></xsl:when> -->
				<xsl:when test="contains(Policy/LOBCd,'BMISC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BOPGL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BOPPR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CAVN')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CFIRE')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'COMR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CONTR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CPMP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CRIME')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'DISAB')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EL')">Comml</xsl:when>
	<!-- 			<xsl:when test="contains(Policy/LOBCd,'EQ')"></xsl:when> -->
				<xsl:when test="contains(Policy/LOBCd,'EQLIA')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EXLIA')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'FIDTY')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'FIDUC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'FLOOD')"></xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'GARAG')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HBB')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HLTH')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'INMAR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'JUDCL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'KIDRA')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'LAW')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'LICPT')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'LL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'LMORT')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'LSTIN')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'MEDIA')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'MHOME')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'MMAL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'Motorcycle')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'MPL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'MTRCR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'NWFGR')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'OLIB')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PHYS')">Comml</xsl:when>
	<!-- 			<xsl:when test="contains(Policy/LOBCd,'PKG')"></xsl:when> -->
				<xsl:when test="contains(Policy/LOBCd,'PL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PLMSC')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PUBOF')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'RECV')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'RRPRL')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'SCAP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'SFRNC')">FarmRanch</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'SMP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'SURE')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'TECH')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'TRUCK')">Comml</xsl:when>
	<!-- 			<xsl:when test="contains(Policy/LOBCd,'UMBRL')"></xsl:when> -->
	<!-- 			<xsl:when test="contains(Policy/LOBCd,'UN')"></xsl:when> -->
				<xsl:when test="contains(Policy/LOBCd,'WCMA')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'WIND')">Pers</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'WORKP')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'WORKV')">Comml</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'YACHT')">Pers</xsl:when>
				<xsl:otherwise>Unknown</xsl:otherwise>	
			</xsl:choose>					
		</xsl:variable>
		<xsl:variable name="message">
			<xsl:choose>
				<xsl:when test="contains(Policy/LOBCd,'AIRC')">AircraftPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AIRPFB')">AirportFBOPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AVPKG')">AviationPkgPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BANDM')">BoilerMachineryPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'BOP')">BOPPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AUTOB')">CommlAutoPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'INMRC')">CommlInlandMarinePolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CPKGE')">CommlPkgPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PROP')">CommlPropertyPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'UMBRC')">CommlUmbrellaPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CRIM')">CrimePolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CYBER')">CyberLiabilityPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'DO')">DirectorsAndOfficersPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'DFIRE')">DwellFirePolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EPLI')">EPLIPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'EO')">ErrorsAndOmissionsPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CFRM')">FarmPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'CGL')">GeneralLiabilityPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HANG')">HangarLiabilityPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'HOME')">HomePolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'AUTOP')">PersAutoPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'INMRP')">PersInlandMarinePolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'PPKGE')">PersPkgPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'UMBRP')">PersUmbrellaPolicy</xsl:when>
<!-- 				<xsl:when test="contains(Policy/LOBCd,'')">ProductsLiabilityPolicy</xsl:when> -->
				<xsl:when test="contains(Policy/LOBCd,'BOAT')">WatercraftPolicy</xsl:when>
				<xsl:when test="contains(Policy/LOBCd,'WORK')">WorkCompPolicy</xsl:when>
<!-- 				<xsl:when test="contains(Policy/LOBCd,'')">WorkCompProofCoverage</xsl:when> -->
				<xsl:otherwise>Policy</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="contains(BusinessPurposeTypeCd,'NBQ')">Quote</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'NBS')">Add</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'PCH')">Mod</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'RIX')">Reissue</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'RWL')">Renew</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'REI')">Reinstate</xsl:when>
				<xsl:when test="contains(BusinessPurposeTypeCd,'XLN')">Cancel</xsl:when>
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
			
			<xsl:if test="$mode='Pers'">
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="Pers" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="Pers" />
				<xsl:apply-templates select="Policy" mode="Pers"/>
				<xsl:apply-templates select="Location" mode="Pers" />
				<xsl:apply-templates select="LocationUWInfo" mode="Pers"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="Pers"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="Pers"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="Pers"/>
			</xsl:if>
			
			<xsl:if test="$mode='Comml'">
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="Comml" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="Comml" />
				<xsl:apply-templates select="Policy" mode="Comml"/>
				<xsl:apply-templates select="Location" mode="Comml" />
				<xsl:apply-templates select="LocationUWInfo" mode="Comml"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="Comml"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="Comml"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="Comml"/>
			
			</xsl:if>
			
			<xsl:if test="$mode='FarmRanch'">
			
				<!-- LOB_HEADER -->
				<xsl:apply-templates select="Producer" mode="FarmRanch" />
				<xsl:apply-templates select="InsuredOrPrincipal" mode="FarmRanch" />
				<xsl:apply-templates select="Policy" mode="FarmRanch"/>
				<xsl:apply-templates select="Location" mode="FarmRanch" />
				<xsl:apply-templates select="LocationUWInfo" mode="FarmRanch"/> 
				<xsl:apply-templates select="FarmSubLocation" mode="FarmRanch"/> 
				
				<!-- LOB_BODY -->
				<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" mode="FarmRanch"/>
				
				<!-- LOB_RQ/RSFOOTER -->
				<xsl:apply-templates select="RemarkText"/>
				<xsl:apply-templates select="FileAttachmentInfo"/>
				<xsl:apply-templates select="PolicySummaryInfo" mode="FarmRanch"/>
			</xsl:if>
			
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Coverage Aggregates -->
	<xsl:template match="Coverage" mode="Pers">
		<PersCoverage>
			<xsl:apply-templates select="@*|node()" mode="Pers"/>
		</PersCoverage>
	</xsl:template>
	<xsl:template match="Coverage" mode="Comml">
		<CommlCoverage>
			<xsl:apply-templates select="@*|node()" mode="Comml"/>
		</CommlCoverage>
	</xsl:template>
	<xsl:template match="Coverage" mode="FarmRanch">
		<CommlCoverage>
			<xsl:apply-templates select="@*|node()" mode="FarmRanch"/>
		</CommlCoverage>
	</xsl:template>
	
	<!-- Collapse Policy Aggregates -->
	<xsl:template match="Policy" mode="Pers">
		<PersPolicy>
			<xsl:apply-templates select="@*|node()" mode="Pers"/>
		</PersPolicy>
	</xsl:template>
	<xsl:template match="CommlPolicy" mode="Comml">
		<CommlPolicy>
			<xsl:apply-templates select="@*|node()" mode="Comml"/>
		</CommlPolicy>
	</xsl:template>
	<xsl:template match="FarmRanchPolicy" mode="FarmRanch">
		<FarmRanchPolicy>
			<xsl:apply-templates select="@*|node()" mode="FarmRanch"/>
		</FarmRanchPolicy>
	</xsl:template>
	
	<!-- Collapse Driver Aggregates -->
	<xsl:template match="Driver" mode="Pers">
		<PersDriver>
			<xsl:apply-templates select="@*|node()" mode="Pers"/>
		</PersDriver>
	</xsl:template>
	<xsl:template match="Driver" mode="Comml">
		<CommlDriver>
			<xsl:apply-templates select="@*|node()" mode="Comml"/>
		</CommlDriver>
	</xsl:template>
	<xsl:template match="Driver" mode="FarmRanch">
		<CommlDriver>
			<xsl:apply-templates select="@*|node()" mode="FarmRanch"/>
		</CommlDriver>
	</xsl:template>
	
	<!-- Collapse Vehicle Aggregates -->
	<xsl:template match="Vehicle" mode="Pers">
		<PersVeh>
			<xsl:apply-templates select="@*|node()" mode="Pers"/>
		</PersVeh>
	</xsl:template>
	<xsl:template match="Vehicle" mode="Comml">
		<CommlVeh>
			<xsl:apply-templates select="@*|node()" mode="Comml"/>
		</CommlVeh>
	</xsl:template>
	<xsl:template match="Vehicle" mode="FarmRanch">
		<CommlVeh>
			<xsl:apply-templates select="@*|node()" mode="FarmRanch"/>
		</CommlVeh>
	</xsl:template>
	
	<!-- Collapse PersVehSupplement Aggregate -->
	<xsl:template match="PersVehSupplement" mode="Pers">
		<xsl:apply-templates select="@*|node()" mode="Pers"/>
	</xsl:template>
</xsl:stylesheet>


