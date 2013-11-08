<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Post Type Body --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfset qBlogPosts = application.fapi.getContentObjects(typename="blogPost", orderby="posteddatetime DESC")>
<cfset numBlogPosts = application.fapi.getConfig("blogfc", "numBlogPosts")>

<cfoutput>
	<cfloop query="qBlogPosts" endrow="#numBlogPosts#">
		<section>
			<skin:view typename="blogPost" objectid="#qBlogPosts.objectid#" webskin="displayBody" bDetail="false" />
		</section>
	</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="false">