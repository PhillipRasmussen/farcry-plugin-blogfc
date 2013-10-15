<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog RSS Feed --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->
<!--- @@viewstack: data --->
<!--- @@mimetype: application/rss+xml --->
<!--- @@fualias: rss --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfparam name="url.catid" default="">

<cfset oEnv = application.fapi.getContentType(typename="configEnvironment")>
<cfset qBlogPosts = application.fapi.getContentObjects(typename="blogPost", orderby="posteddatetime DESC")>

<cfset dateMask = "ddd, dd mmm yyyy">
<cfset timeMask = "HH:mm:ss">
<cfset maxrows = 25>
<cfset count = 1>

<cfoutput>
<rss version="2.0">
<channel>
<title>#xmlFormat(application.fapi.getConfig("general", "sitetitle"))#</title>
<link>#xmlFormat(oEnv.getCanonicalURL() & application.fapi.getConfig("blogfc", "urlStem"))#</link>
<description/>
<language>en-us</language>
<pubDate>#xmlFormat(dateFormat(dateConvert("local2utc", now()), dateMask) & " " & timeFormat(dateConvert("local2utc", now()), timeMask))# +0000</pubDate>
<lastBuildDate>#xmlFormat(dateFormat(dateConvert("local2utc", now()), dateMask) & " " & timeFormat(dateConvert("local2utc", now()), timeMask))# +0000</lastBuildDate>
<generator>FarCry Blog</generator>
<docs>http://blogs.law.harvard.edu/tech/rss</docs>
<managingEditor>#xmlFormat(application.fapi.getConfig("general", "adminemail"))#</managingEditor>
<webMaster>#xmlFormat(application.fapi.getConfig("general", "adminemail"))#</webMaster>
<cfloop query="qBlogPosts">
	<cfset stBlogPost = application.fapi.getContentObject(typename="blogPost", objectid=qBlogPosts.objectid)>
	<cfif NOT len(url.catid) OR arrayFindNoCase(stBlogPost.aCategories, url.catid)>
		<cfset qCategories = application.fapi.getContentObjects(typename="blogCategory", lProperties="objectid,title", objectid_IN=arrayToList(stBlogPost.aCategories), orderby="label ASC")>

		<item>
		<title>#xmlFormat(stBlogPost.title)#</title>
		<link>#xmlFormat(oEnv.getCanonicalURL() & application.fapi.getLink(type="blogPost", objectid=stBlogPost.objectid))#</link>
		<description>#xmlFormat(stBlogPost.body)#</description>
		<cfloop query="qCategories">
			<category>#xmlFormat(qCategories.title)#</category>		
		</cfloop>
		<pubDate>#xmlFormat(dateFormat(dateConvert("local2utc", stBlogPost.posteddatetime), dateMask) & " " & timeFormat(dateConvert("local2utc", stBlogPost.posteddatetime), timeMask))# +0000</pubDate>
		<guid>#xmlFormat(oEnv.getCanonicalURL() & application.fapi.getLink(type="blogPost", objectid=stBlogPost.objectid))#</guid>
		</item>

		<cfset count = count + 1>
	</cfif>
	<cfif count gt maxrows>
		<cfbreak>
	</cfif>
</cfloop>
</channel>
</rss>
</cfoutput>

<cfsetting enablecfoutputonly="false">