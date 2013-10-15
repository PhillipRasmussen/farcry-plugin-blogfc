<cfsetting enablecfoutputonly="true" showdebugoutput="false"> 

<cfset stem = application.fapi.getConfig("blogfc", "urlStem")>
<cfset alias = stObj.title>
<cfif len(stObj.alias)>
	<cfset alias = stObj.alias>
</cfif>

<!--- return the friendly url --->
<cfoutput>#stem#/#alias#</cfoutput>

<cfsetting enablecfoutputonly="false">