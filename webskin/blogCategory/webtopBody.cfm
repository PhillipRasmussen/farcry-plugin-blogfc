<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Category Webtop Body --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft">

<ft:objectAdmin
	typename="blogCategory"
	columnList="label"
	numitems="100"
	sortableColumns="label"
	lFilterFields="label"
	sqlOrderBy="label ASC" />


<cfsetting enablecfoutputonly="false">