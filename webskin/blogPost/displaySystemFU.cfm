<cfsetting enablecfoutputonly="true" showdebugoutput="false"> 

<cfset stem = application.fapi.getConfig("blogfc", "urlStem")>
<cfset year = datepart("yyyy", stObj.posteddatetime)>
<cfset month = datepart("m", stObj.posteddatetime)>
<cfset day = datepart("d", stObj.posteddatetime)>
<cfset alias = stObj.title>
<cfif len(stObj.alias)>
	<cfset alias = stObj.alias>
</cfif>

<!--- return the friendly url --->
<cfoutput>#stem#/#year#/#month#/#day#/#alias#</cfoutput>

<cfsetting enablecfoutputonly="false">