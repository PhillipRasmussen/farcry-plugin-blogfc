<cfcomponent displayName="Blog Category" extends="farcry.core.packages.types.types"
	bFriendly="true" bObjectBroker="true">

	<cfproperty name="title" type="string" required="false"
		ftSeq="1" ftFieldset="Category" ftLabel="Title">

	<cfproperty name="alias" type="string" required="false" default=""
		hint="The old friendly URL alias used by BlogCFC">


	<cffunction name="getBlogPostsByCategory" returntype="query">
		<cfargument name="objectid" required="true" hint="The category objectid used to select the blog posts">
		<cfargument name="maxrows" required="false" default="10">

		<cfset var qBlogPosts = application.fapi.getContentObjects(typename="blogPost", aCategories_IN=arguments.objectid, orderby="posteddatetime DESC", maxrows=arguments.maxrows)>

		<cfreturn qBlogPosts>
	</cffunction>

</cfcomponent>