<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Post Webtop Body --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft">

<ft:objectAdmin
	typename="blogPost"
	columnList="title,status,posteddatetime,datetimelastupdated"
	sortableColumns="title,status,posteddatetime,datetimelastupdated"
	lFilterFields="title"
	sqlOrderBy="posteddatetime DESC" />


<cfsetting enablecfoutputonly="false">