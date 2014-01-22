<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Post Type Body --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfset numBlogPosts = application.fapi.getConfig("blogfc", "numBlogPosts", 10)>
<cfset qBlogPosts = application.fapi.getContentObjects(typename="blogPost", orderby="posteddatetime DESC", maxrows=numBlogPosts)>

<cfoutput>
	<cfloop query="qBlogPosts">
		<section>
			<skin:view typename="blogPost" objectid="#qBlogPosts.objectid#" webskin="displayBody" bDetail="false" />
		</section>
	</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="false">