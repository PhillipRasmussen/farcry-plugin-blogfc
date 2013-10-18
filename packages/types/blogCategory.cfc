<cfcomponent displayName="Blog Category" extends="farcry.core.packages.types.types" bFriendly="true">

	<cfproperty name="title" type="string" required="false"
		ftSeq="1" ftWizardStep="" ftFieldset="Category" ftLabel="Title">

	<cfproperty name="alias" type="string" required="false" default=""
		hint="The old friendly URL alias used by BlogCFC">


	<cffunction name="getBlogPostsByCategory" returntype="query">
		<cfargument name="objectid" required="true" hint="The category objectid used to select the blog posts">

		<cfset var qBlogPosts = queryNew("objectid")>

		<cfquery name="qBlogPosts" datasource="#application.dsn#">
			SELECT objectid
			FROM #application.dbowner#blogPost_aCategories
				INNER JOIN #application.dbowner#blogPost ON (#application.dbowner#blogPost_aCategories.parentid = #application.dbowner#blogPost.objectid)
			WHERE data = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#">
			ORDER BY posteddatetime DESC
		</cfquery>

		<cfreturn qBlogPosts>
	</cffunction>

</cfcomponent>