<cfcomponent displayName="Blog Post" extends="farcry.core.packages.types.types" 
	bFriendly="true" fualias="blog">

	<cfproperty name="title" type="string" required="false"
		ftSeq="1" ftFieldset="Blog Details" ftLabel="Title">

	<cfproperty name="aCategories" type="array" required="false"
		ftSeq="2" ftFieldset="Blog Details" ftLabel="Categories"
		ftType="typeahead" ftJoin="blogCategory" ftLibraryDataSQLOrderBy="label ASC">

	<cfproperty name="posteddatetime" type="date" required="false" 
		ftSeq="3" ftFieldset="Blog Details" ftLabel="Date Posted"
		ftType="datetime" ftDefaultType="Evaluate" ftDefault="now()" 
		ftDateFormatMask="dd mmm yyyy" ftTimeFormatMask="hh:mm tt" 
		ftShowTime="true">

	<cfproperty name="body" type="longchar" required="false"
		ftSeq="4" ftFieldset="Content" ftLabel="Body" 
		ftType="richtext">

	<cfproperty name="aRelated" type="array" required="false"
		ftSeq="5" ftFieldset="Relationships" ftLabel="Related Blog Posts"
		ftType="array" ftJoin="blogPost" ftLibraryDataSQLOrderBy="posteddatetime DESC">

	<cfproperty name="views" type="integer" required="false" default=""
		hint="The number of blog entry views from BlogCFC">

	<cfproperty name="alias" type="string" required="false" default=""
		hint="The old friendly URL alias used by BlogCFC">

	<cfproperty name="status" type="string" required="false" default="draft" ftLabel="Status">

</cfcomponent>