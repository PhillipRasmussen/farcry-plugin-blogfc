<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Body --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfparam name="stParam.bDetail" default="true">

<cfset qCategories = application.fapi.getContentObjects(typename="blogCategory", lProperties="objectid,title", objectid_IN=arrayToList(stObj.aCategories), orderby="label ASC")>
<cfset authorName = application.fapi.getConfig("blogfc", "author")>

<cfoutput>
	<h1><a href="#application.fapi.getLink(typename="blogPost", objectid=stObj.objectid)#">#stObj.title#</a></h1>
	<p class="blog-byline">
		<i class="icon-time icon-fixed-width"></i> #lsDateFormat(stObj.posteddatetime, "d mmmm yyyy")# #lsTimeFormat(stObj.posteddatetime, "h:mm tt")#
		<cfif len(authorName)>by #authorName#</cfif>
		<br>
		<cfif qCategories.recordCount>
			<i class="icon-tag icon-fixed-width"></i> 
			<cfloop query="qCategories">
				<a href="#application.fapi.getLink(typename="blogCategory", objectid=qCategories.objectid)#">#qCategories.title#</a>
				<cfif qCategories.currentrow neq qCategories.recordCount>&middot;</cfif>
			</cfloop>
			<br>
		</cfif>
		<cfif len(application.fapi.getConfig("blogfc", "disqusShortname"))>
			<i class="icon-comments icon-fixed-width"></i> <a href="#application.fapi.getLink(typename="blogPost", objectid=stObj.objectid)###disqus_thread" data-disqus-identifier="#stObj.objectid#">Comments</a>
		</cfif>
	</p>
	<div class="content blog-content">
		#stObj.body#
	</div>
	<cfif stParam.bDetail>
		<cfif arrayLen(stObj.aRelated)>
			<h3>Related Blog Posts</h3>
			<ul class="blog-related">
				<cfloop from="1" to="#arrayLen(stObj.aRelated)#" index="i">
					<li><skin:buildlink typename="blogPost" objectid="#stObj.aRelated[i]#" /></li>
				</cfloop>
			</ul>
		</cfif>
		<div class="blog-comments">
			<skin:view stObject="#stObj#" webskin="displayComments" />
		</div>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="false">