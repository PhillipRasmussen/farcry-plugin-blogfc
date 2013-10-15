<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Category Webtop Body --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft">

<ft:objectAdmin
	typename="#stObj.name#"
	columnList="label"
	sortableColumns="label"
	lFilterFields="label"
	sqlOrderBy="label ASC" />


<cfsetting enablecfoutputonly="false">