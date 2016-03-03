<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/*">
    <Master>
      <ActionCd>
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
      </ActionCd>
      <xsl:for-each select="descendant::Producer|descendant::InsuredOrPrincipal|descendant::AddititionalInterest|descendant::ClaimsParty|descendant::PersDriver|descendant::CommlDriver">
        <Party Type="{local-name()}">
          <xsl:apply-templates select="@*|node()" />
        </Party>
      </xsl:for-each>
      <xsl:for-each select="descendant::PersPolicy|descendant::CommlPolicy|descendant::FarmRanchPolicy">
        <Policy Type="{local-name()}">
          <xsl:apply-templates select="@*|node()" />
        </Policy>
      </xsl:for-each>
      <xsl:for-each select="descendant::Location">
        <xsl:copy>
          <xsl:apply-templates select="@*|node()" />
          <!-- TODO match Dwell|CommlSubLocation|FarmSubLocation based on @LocationRef -->
          <xsl:for-each select="../descendant::Dwell|descendant::CommlSubLocation|descendant::FarmSubLocation">
            <xsl:copy>
              <xsl:apply-templates select="@*|node()" />
            </xsl:copy>
          </xsl:for-each>
        </xsl:copy>
      </xsl:for-each>
      <xsl:for-each select="descendant::PersVeh|descendant::CommlVeh">
        <Vehicle Type="{local-name()}">
          <xsl:apply-templates select="@*|node()" />
        </Vehicle>
      </xsl:for-each>
      <xsl:apply-templates select="PropertySchedule|Watercraft|WatercraftAccessory" />
      <xsl:apply-templates select="*[contains(local-name(),'LineBusiness')]" />
      <xsl:apply-templates select="RemarkText|FileAttachmentInfo" />
    </Master>
  </xsl:template>
  <xsl:template match="Producer|InsuredOrPrincipal|AdditionalInterest|ClaimsParty|GeneralParty|PersDriver|CommlDriver">
    <!-- moved to root -->
  </xsl:template>
  <xsl:template match="PersPolicy|CommlPolicy|FarmRanchPolicy">
    <!-- moved to root -->
  </xsl:template>
  <xsl:template match="PersVeh|CommlVeh">
    <!-- moved to root -->
  </xsl:template>
  <xsl:template match="Dwell|CommlSubLocation|FarmSubLocation">
    <!-- moved to location -->
  </xsl:template>
  <xsl:template match="PersCoverage|CommlCoverage|QuotedCoverage">
    <Coverage Type="{local-name()}">
      <xsl:apply-templates select="@*|node()" />
    </Coverage>
  </xsl:template>
  <!-- TODO : Move MiscParty to root ? -->
  <!-- TODO : Move OtherOrPriorPolicy to root ? -->
  <!-- TODO : Move PartialPolicy to root ? -->
  <!-- TODO : Move UnderwritingDecisionInfo to root and transform to Party ? -->
</xsl:stylesheet>

