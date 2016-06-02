<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/*[not(contains(local-name(),'ACORD'))]|/ACORD/*[contains(local-name(),'InsuranceSvc')]/*[not(contains(local-name(),'RqUID') or contains(local-name(),'SPName'))]">
		<xsl:variable name="message">
			<xsl:choose>
				<xsl:when test="contains(local-name(),'Notify')">PolicyNotify</xsl:when>
				<xsl:when test="contains(local-name(),'NotifyRs')">PolicyNotifyRs</xsl:when>
				<xsl:when test="contains(local-name(),'Rq')">PolicyRq</xsl:when>
				<xsl:when test="contains(local-name(),'Rs')">PolicyRs</xsl:when>
				<xsl:otherwise>PolicyMsg</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="{$message}">
			
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
			<xsl:apply-templates select="PendManualProcessingInd"/>  
			<xsl:apply-templates select="AppetiteRequestInd"/>  <!-- TODO : Should this be a BusinessPurposeTypeCd ? -->
			<xsl:apply-templates select="FormsRequestedCd"/>
			<xsl:apply-templates select="SaveIndicationCd"/> 
			<xsl:apply-templates select="ChangeStatus" />
			<xsl:apply-templates select="ModInfo" /> 
			<xsl:apply-templates select="MsgStatus" /> 
			<xsl:apply-templates select="ResponseURL" /> 
			<xsl:apply-templates select="CancelNonRenewInfo"/>
			<xsl:apply-templates select="ReinstateInfo"/>
			
			<!-- LOB_HEADER -->
			<xsl:apply-templates select="Producer" />
			<xsl:apply-templates select="InsuredOrPrincipal" />
			<xsl:apply-templates select="Policy|PersPolicy|CommlPolicy|FarmRanchPolicy"/>
			<xsl:apply-templates select="Location" />
			<xsl:apply-templates select="LocationUWInfo|CommlSubLocation|FarmSubLocation"/> 
			
			<!-- LOB_BODY -->
			<xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]"/>
			
			<!-- LOB_RQ/RSFOOTER -->
			<xsl:apply-templates select="RemarkText"/>
			<xsl:apply-templates select="FileAttachmentInfo"/>
			<xsl:apply-templates select="PolicySummaryInfo"/>
			<xsl:apply-templates select="Extension"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Coverage Aggregates -->
	<xsl:template match="PersCoverage|CommlCoverage">
		<xsl:element name="Coverage">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Policy Aggregates -->
	<xsl:template match="PersPolicy|CommlPolicy|FarmRanchPolicy">
		<xsl:element name="Policy">
			<xsl:apply-templates select="@*|node()"/>
			<!-- pull up MiscParty from message -->
			<xsl:apply-templates select="../MiscParty"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Driver Aggregates -->
	<xsl:template match="PersDriver|CommlDriver">
		<xsl:element name="Driver">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Collapse Vehicle Aggregates -->
	<xsl:template match="PersVeh|CommlVeh">
		<xsl:element name="Vehicle">
			<xsl:choose>
				<!-- special handling for pers vehicles -->
				<xsl:when test="contains(local-name(),'PersVeh')">
				  <xsl:apply-templates select="@*"/>
				  <xsl:apply-templates select="ItemIdInfo|Manufacturer|ManufacturerCd|Model|ModelCd|ModelYear|VehBodyTypeCd|VehBodyTypeDesc|NumTotalVehRatingPoints|VehTypeCd|VehLength|Registration|Width|AntiTheftDeviceInfo|POLKRestraintDeviceCd|HighTheftInd|TonRatingCapacityCd|CostNewAmt|NumDaysDrivenPerWeek|EstimatedAnnualDistance|FullTermAmt|NetChangeAmt|WrittenAmt|Displacement|Horsepower|LeasedVehInd|LeasedDt|NumCylinders|PurchaseDt|PurchasePriceAmt|TerritoryCd|VehIdentificationNumber|ChassisSerialNumber|EngineSerialNumber|TransmissionSerialNumber|ColorCd|VehSymbolCd|AdditionalInterest|Color|ColorInterior|GrossVehWeight|CombinedVehWeight|InspectionInfo|RateSubClassCd|VehRateGroupInfo|ItemModificationInfo|ExistingUnrepairedDamageInfo|ExistingUnrepairedDamageDesc|DrivenByCoWorkersInd" />
				  <PersVehSupplement>
				    <!-- JSTE - Removed 'PurchaseDt' since its in PCVEH -->
				  	<xsl:apply-templates select="AlteredInd|AntiLockBrakeCd|BumperDiscountInd|CarpoolInd|DamageabilityCd|DaytimeRunningLightInd|EngineTypeCd|GaragingCd|MaximumSpeed|DistanceOneWay|MultiCarDiscountInd|NewVehInd|NonOwnedVehInd|NumAxles|LengthTimePerMonth|NumYouthfulOperators|OdometerReading|PhysicalDamageRateClassCd|PricingCd|PrincipalOperatorInd|RateClassCd|ResidualMarketFacilityInd|SeenCarInd|TerritoryCodeCommutingDestinationCd|TractionControlInd|RegisteredVehInd|AlterationsAmt|VehInspectionStatusCd|VehPerformanceCd|VehSalvageTitleNumber|VehUseCd|FourWheelDriveInd|QuestionAnswer|SeatBeltTypeCd|AirBagTypeCd|OdometerReadingAtPurchase|OdometerReadingAsOfDt|PreviouslyLeasedVehInd|BusinessAnnualDistance|AlternateDrivingStateProvCd|AlternateDrivingStateProvUsePct|NumPassengers|ReasonLiabilityRefusedCd|ResidualMarketFacilityTierDt|ResidualMarketFacilityTierCd|TierCd|BIPDSymbolCd|MedPayPIPLiabilitySymbolCd|SalvagedInd|PresentValueAmt|AppraiserActivityInfo"/>
				  </PersVehSupplement>
				  <xsl:apply-templates select="Coverage|OdometerReadingAtPurchase|OdometerReadingAsOfDt|PreviouslyLeasedVehInd|BusinessAnnualDistance|AlternateDrivingStateProvCd|AlternateDrivingStateProvUsePct|NumPassengers|ReasonLiabilityRefusedCd|ResidualMarketFacilityTierDt|ResidualMarketFacilityTierCd|TierCd|BIPDSymbolCd|MedPayPIPLiabilitySymbolCd|CollisionSymbolCd|ComprehensiveOTCSymbolCd|SalvageInd|PresentValueAmt|AppraiserActivityInfo" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>


