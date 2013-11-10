<cfcomponent extends="farcry.core.webtop.install.manifest">

	<cfset this.name = "BlogFC" />
	<cfset this.description = "<strong>BlogFC</strong> is a simple blog plugin for FarCry Core." />
	<cfset this.lRequiredPlugins = "" />
	<cfset addSupportedCore(majorVersion="7", minorVersion="0", patchVersion="0") />

</cfcomponent>