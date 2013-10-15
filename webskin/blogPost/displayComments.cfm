<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Comments --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfset oEnv = application.fapi.getContentType(typename="configEnvironment")>

<cfif len(application.fapi.getConfig("blogfc", "disqusShortname"))>
<cfoutput>
	<div id="disqus_thread"></div>
	<script type="text/javascript">
	    var disqus_shortname = '#application.fapi.getConfig("blogfc", "disqusShortname")#';
	    var disqus_identifier = '#stObj.objectid#';
	    var disqus_title = '#stObj.title#';
	    var disqus_url = '#oEnv.getCanonicalURL()##application.fapi.getLink(type=stObj.typename, objectid=stObj.objectid)#';

	    (function() {
	        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
	        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
	        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	    })();
	</script>	
</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="false">