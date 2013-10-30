<cfsetting enablecfoutputonly="true">

<cfparam name="form.blogcfcDSN" default="">
<cfparam name="form.migrate" default="0">

<cfset dsnError = "">
<cfset exportOutput = "">

<cfset oEnv = application.fapi.getContentType(typename="configEnvironment")>


<!--- get the blogPosts and the blog comments related to them --->
<cfif len(form.blogcfcDSN)>
	<cftry>

		<cfset qBlogPosts = application.fapi.getContentObjects(typename="blogPost", lProperties="objectid,title,posteddatetime")>
		<cfquery name="qBlogComments" datasource="#form.blogcfcDSN#">
			SELECT id
			FROM tblblogcomments
			WHERE 1=1
				AND (moderated = 1 OR moderated IS NULL)
				AND (subscribeonly = 0 OR subscribeonly IS NULL)
			ORDER BY posted ASC
		</cfquery>

		<cfcatch>
			<cfset dsnError = cfcatch.message & "<br>" & cfcatch.detail>
		</cfcatch>
	</cftry>


	<!--- do the migration and stream the exported xml file --->
	<cfif NOT len(dsnError) AND form.migrate eq 1>

<cfsavecontent variable="exportOutput">
<cfoutput><?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:dsq="http://www.disqus.com/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:wp="http://wordpress.org/export/1.0/">
	<channel>
		<cfloop query="qBlogPosts"> 			
			<cfquery name="qComments" datasource="#form.blogcfcDSN#">
				SELECT *
				FROM tblblogcomments
				WHERE 1=1
					AND entryidfk = '#qBlogPosts.objectid#'
					AND (moderated = 1 OR moderated IS NULL)
					AND (subscribeonly = 0 OR subscribeonly IS NULL)
				ORDER BY posted ASC
			</cfquery>
			<cfset link = oEnv.getCanonicalURL() & application.fapi.getLink(type="blogPost", objectid=qBlogPosts.objectid)>
			<item>
				<title>#xmlFormat(qBlogPosts.title)#</title>
				<link>#xmlFormat(link)#</link>
				<content:encoded><![CDATA[]]></content:encoded>
				<dsq:thread_identifier>#xmlFormat(qBlogPosts.objectid)#</dsq:thread_identifier>
				<wp:post_date_gmt>#xmlFormat(dateFormat(qBlogPosts.posteddatetime, 'YYYY-MM-DD' ))# #xmlFormat(timeFormat(qBlogPosts.posteddatetime, 'HH:mm:ss' ))#</wp:post_date_gmt>
				<wp:comment_status>open</wp:comment_status>
				<cfloop query="qComments">
					<cfif len(qComments.comment) gt 1>
					<wp:comment>
						<wp:comment_id>#xmlFormat(qComments.id)#</wp:comment_id>
						<wp:comment_author>#xmlFormat(qComments.name)#</wp:comment_author>
						<wp:comment_author_email><cfif len(qComments.email)>#xmlFormat(qComments.email)#<cfelse>noreply@dummy.email</cfif></wp:comment_author_email>
						<wp:comment_author_url>#xmlFormat(qComments.website)#</wp:comment_author_url>
						<wp:comment_author_IP>127.0.0.1</wp:comment_author_IP>
						<wp:comment_date_gmt>#xmlFormat(dateFormat(qComments.posted, 'YYYY-MM-DD' ))# #xmlFormat(timeFormat(qComments.posted, 'HH:mm:ss' ))#</wp:comment_date_gmt>
						<wp:comment_content><![CDATA[#qComments.comment#]]></wp:comment_content>
						<wp:comment_approved><cfif qComments.moderated eq 1>1<cfelse>0</cfif></wp:comment_approved>
						<wp:comment_parent>0</wp:comment_parent>
					</wp:comment>
					</cfif>
				</cfloop>
			</item>					 
		</cfloop>
	</channel>
</rss>
</cfoutput>
</cfsavecontent>

		<!--- stream the file --->
		<cfset application.fapi.stream(exportOutput, "text/xml;charset=utf-8", "blogcfc_comment_export_#dateFormat(now(),'yyyymmdd')#.xml")>
		
	</cfif>

</cfif>


<cfoutput>

<h1><i class="fa fa-upload"></i> Export Comments from BlogCFC</h1>

<p class="muted">You can use this tool to export your old comments from a Blog CFC database.</p>

<p>Blog comments will be exported in a format suitable for uploading/importing to 
<a href="http://disqus.com/" target="_blank">Disqus</a>. You can save the exported file, then log 
in to your Disqus account and go to <code>Admin &gt; Discussions &gt; Import &gt; Generic (WXR)</code> to perform the upload. 
Also be sure to set your Disqus "shortname" in FarCry's <code>Admin &gt; Blog Configuration</code>.</p>

<p>Note: You must run the <a href="?id=plugins.blog.migrate.content">Import Content from BlogCFC</a> 
before exporting comments so that the correct friendly URLs can be used in the export file.</p>


<form action="" method="post" style="margin-top: 25px; margin-bottom: 25px;">

	<!--- prompt for blogcfc dsn --->
	<div>
		<label style="display:inline;margin-right:10px;font-weight: bold;">BlogCFC DSN</label>
		<input style="margin-bottom: 0;" name="blogcfcDSN" type="text" value="#form.blogcfcDSN#">
		<button class="btn btn-primary" type="submit">Connect to BlogCFC DSN</button>
	</div>

	<!--- show the dsn info and migration prompt/output --->
	<cfif len(form.blogcfcDSN)>
		<div class="well" style="margin-top: 20px;">
			<p>Using DSN <strong>#form.blogcfcDSN#</strong></p>

			<cfif len(dsnError)>
				<p>Error: #dsnError#</p>
			<cfelse>
				<p>Ready to export...</p>
				<p>
					Found <strong>#qBlogComments.recordCount#</strong> blog comments.<br>
				</p>
				<cfif form.migrate eq 1>
					<p><strong>Export complete.</strong></p>
				<cfelse>
					<p><button class="btn btn-primary" name="migrate" type="submit" value="1">Export Data</button></p>
				</cfif>
			</cfif>
		</div>
	</cfif>

</form>

</cfoutput>

<cfsetting enablecfoutputonly="false">