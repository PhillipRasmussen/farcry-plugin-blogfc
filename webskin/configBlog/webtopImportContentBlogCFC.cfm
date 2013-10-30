<cfsetting enablecfoutputonly="true">

<cfparam name="form.blogcfcDSN" default="">
<cfparam name="form.migrate" default="0">

<cfset dsnError = "">
<cfset migrateOutput = "">


<!--- get content types --->
<cfset oBlogPost = application.fapi.getContentType(typename="blogPost")>
<cfset oBlogCategory = application.fapi.getContentType(typename="blogCategory")>


<!--- get the blog categories and blog entries from the blogcfc dsn --->
<cfif len(form.blogcfcDSN)>
	<cftry>
		<cfquery name="qBlogCategories" datasource="#form.blogcfcDSN#">
			SELECT *
			FROM tblblogcategories
			ORDER BY categoryname DESC
		</cfquery>
		<cfquery name="qBlogPosts" datasource="#form.blogcfcDSN#">
			SELECT *
			FROM tblblogentries
		</cfquery>

		<!--- do the migration and capture output --->
		<cfif form.migrate eq 1>

			<cfsavecontent variable="migrateOutput">
				<cfoutput>
				<p>
					Importing blog categories...
					<cfloop query="qBlogCategories">
						<cfset stBlogCategory = structNew()>
						<cfset stBlogCategory.objectid = qBlogCategories.categoryid>
						<cfset stBlogCategory.label = qBlogCategories.categoryname>
						<cfset stBlogCategory.title = qBlogCategories.categoryname>
						<cfset stBlogCategory.alias = qBlogCategories.categoryalias>
						<cfset stBlogCategory.datetimecreated = now()>
						<cfset stBlogCategory.datetimelastupdated = now()>

						<cfset oBlogCategory.setData(stProperties=stBlogCategory)>
					</cfloop>
					<strong>Done.</strong><br>

					Importing blog entries...
					<cfloop query="qBlogPosts">
						<cfset stBlogPost = structNew()>
						<cfset stBlogPost.objectid = qBlogPosts.id>
						<cfset stBlogPost.label = qBlogPosts.title>
						<cfset stBlogPost.title = qBlogPosts.title>
						<cfset stBlogPost.posteddatetime = qBlogPosts.posted>
						<cfset stBlogPost.body = qBlogPosts.body>
						<cfset stBlogPost.alias = qBlogPosts.alias>
						<cfset stBlogPost.views = qBlogPosts.views>
						<cfif qBlogPosts.released eq 1>
							<cfset stBlogPost.status = "approved">
						<cfelse>
							<cfset stBlogPost.status = "draft">
						</cfif>
						<cfset stBlogPost.datetimecreated = qBlogPosts.posted>
						<cfset stBlogPost.datetimelastupdated = qBlogPosts.posted>

						<cfquery name="qBlogPosts_aCategories" datasource="#form.blogcfcDSN#">
							SELECT categoryidfk
							FROM tblblogentriescategories
							WHERE entryidfk = '#qBlogPosts.id#'
						</cfquery>
						<cfset stBlogPost.aCategories = listToArray(valueList(qBlogPosts_aCategories.categoryidfk))>

						<cfquery name="qBlogPosts_aRelated" datasource="#form.blogcfcDSN#">
							SELECT relatedid
							FROM tblblogentriesrelated
							WHERE entryid = '#qBlogPosts.id#'
						</cfquery>
						<cfset stBlogPost.aRelated = listToArray(valueList(qBlogPosts_aRelated.relatedid))>

						<cfset oBlogPost.setData(stProperties=stBlogPost)>
					</cfloop>
					<strong>Done.</strong>
				</p>
				<p><strong>Import complete.</strong></p>
				</cfoutput>
			</cfsavecontent>
			
		</cfif>

		<cfcatch>
			<cfset dsnError = cfcatch.message & "<br>" & cfcatch.detail>
		</cfcatch>
	</cftry>

</cfif>


<cfoutput>

<h1><i class="fa fa-download"></i> Import Content from BlogCFC</h1>

<p class="muted">You can use this tool to import your old content from a Blog CFC database.</p>

<p>Blog categories and blog entries will be imported into FarCry along with the original friendly URLs.
Pages and users will not be imported. After importing your content you can 
<a href="?id=plugins.blog.migrate.comments">Export Comments from BlogCFC</a> in a format suitable for 
uploading/importing to <a href="http://disqus.com/" target="_blank">Disqus</a>.</p>


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
				<p>Ready to import...</p>
				<p>
					Found <strong>#qBlogCategories.recordCount#</strong> blog categories.<br>
					Found <strong>#qBlogPosts.recordCount#</strong> blog entries.
				</p>
				<cfif form.migrate eq 1>
					#migrateOutput#
				<cfelse>
					<p><button class="btn btn-primary" name="migrate" type="submit" value="1">Import Data</button></p>
				</cfif>
			</cfif>
		</div>
	</cfif>

</form>

</cfoutput>

<cfsetting enablecfoutputonly="false">