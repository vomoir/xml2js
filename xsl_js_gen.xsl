<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<xsl:template match="/class">
	class <xsl:value-of select="@name"/>{
		constructor(<xsl:apply-templates select="property" mode="constructor"/>){
			<xsl:apply-templates select="property"/>
			<xsl:apply-templates select="method"/>
		}
		<xsl:apply-templates select="property" mode="getter"/>
	
	}
<!--
class QrTask{
    /***Test for GitKrakenS */
    constructor(taskId, taskName, taskYear, taskLink, taskShortLink, taskDueDate) {
        console.log("In QrTask - initialising: id= " + taskId + " :name= " + taskName);
        this._taskId = parseInt(taskId);
        this._tsl = taskShortLink;
        this._taskName = taskName;
        this._taskYear = taskYear;
        this._taskLink = taskLink;
        this._taskDueDate = taskDueDate;
        this.getTaskShortLink();
    }
    getTaskName() {
        return this._taskName;
    }

-->
</xsl:template>

<xsl:template match="property" mode="constructor">
	<xsl:for-each select=".">
		<xsl:value-of select="."/>
		<xsl:if test="(following-sibling::property)">,</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template match="property">
			this._<xsl:value-of select="."/> = <xsl:if test="@type = 'number'"> parseInt(</xsl:if><xsl:value-of select="."/><xsl:if test="@type = 'number'">)</xsl:if>;
</xsl:template>

<xsl:template match="property" mode="getter">
		get_<xsl:value-of select="."/>(){
			return this._<xsl:value-of select="."/>;
		}
		set_<xsl:value-of select="."/>( parmIn ){
			<xsl:choose>
				<xsl:when test="@type = 'number'">
			//This regex determines wether a number has been input
			this._<xsl:value-of select="."/> = /^\d+$/.test(parmIn);
				</xsl:when>
				<xsl:when test="@type = 'string'">
				if (parmIn typeof 'string') {
				    // this is a string
	    			this._<xsl:value-of select="."/> = parmIn;
				}

				</xsl:when>
			</xsl:choose>
		}

</xsl:template>

<xsl:template match="method">
			this.<xsl:value-of select="."/>();
</xsl:template>
</xsl:stylesheet>