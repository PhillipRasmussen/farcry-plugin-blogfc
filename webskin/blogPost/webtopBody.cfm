<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Default Webtop Body --->

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft">

<ft:objectAdmin
	typename="#stObj.name#"
	columnList="label,status,posteddatetime,datetimelastupdated"
	sortableColumns="label,status,posteddatetime,datetimelastupdated"
	lFilterFields="label"
	sqlOrderBy="posteddatetime DESC" />


<cfsetting enablecfoutputonly="false">