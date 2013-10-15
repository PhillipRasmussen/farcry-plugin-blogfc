<cfcomponent displayName="Blog Configuration" extends="farcry.core.packages.forms.forms" 
	key="blogfc" hint="Configure settings for the Blog plugin">

	<cfproperty name="author" type="string" required="false"
		ftSeq="1" ftWizardStep="" ftFieldset="General Settings" ftLabel="Author Name"
		ftHint="The author name that will appear in the 'by line' of each blog post. Leave blank to hide the author name.">

	<cfproperty name="urlStem" type="string" required="false" default="/blog"
		ftSeq="2" ftWizardStep="" ftFieldset="General Settings" ftLabel="URL Stem"
		ftValidation="required"
		ftHint="The URL stem that all blog post and blog category URLs will begin with, including the leading slash. e.g: /blog">

	<cfproperty name="numBlogPosts" type="integer" required="false" default="10"
		ftSeq="3" ftWizardStep="" ftFieldset="General Settings" ftLabel="Posts per Page"
		ftType="integer" ftDefault="10" ftValidation="required number"
		ftHint="The number of blog posts to show per page.">

	<cfproperty name="disqusShortname" type="string" required="false" default=""
		ftSeq="10" ftWizardStep="" ftFieldset="Disqus Comments" ftLabel="Disqus Shortname"
		ftType="string" 
		ftHint="The &quot;shortname&quot; of the site you have created in <a target='_blank' href='http://disqus.com'>Disqus</a> to use for blog comment integration.">


	<cfscript>

	function ftValidateUrlStem(objectid,typename,stFieldPost,stMetadata) {
		var stResult = structNew();
		var oField = createObject("component", application.fapi.getPackagePath("formtools","field"));

		// url stem must not be empty and must begin with a slash
		if (NOT len(arguments.stFieldPost.value)) {
			arguments.stFieldPost.value = "/blog";
		}
		else if (left(arguments.stFieldPost.value, 1) neq "/") {
			arguments.stFieldPost.value = "/" & arguments.stFieldPost.value;
		}

		stResult = oField.passed(value=arguments.stFieldPost.value);
		return stResult;
	}

	function ftValidateNumBlogPosts(objectid,typename,stFieldPost,stMetadata) {
		var stResult = structNew();
		var oField = createObject("component", application.fapi.getPackagePath("formtools","field"));

		// numBlogPosts must be a number greater than 0
		if (NOT isNumeric(arguments.stFieldPost.value)) {
			arguments.stFieldPost.value = 10;
		}
		else if (arguments.stFieldPost.value lt 1) {
			arguments.stFieldPost.value = 10;
		}

		stResult = oField.passed(value=arguments.stFieldPost.value);
		return stResult;
	}

	</cfscript>

</cfcomponent>