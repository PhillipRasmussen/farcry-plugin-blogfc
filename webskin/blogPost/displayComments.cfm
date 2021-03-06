<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Blog Comments --->
<!--- @@author: Justin Carter (justin.w.carter@gmail.com) --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfset disqusShortname = application.fapi.getConfig("blogfc", "disqusShortname")>

<cfif len(disqusShortname)>
<cfoutput>
	<div id="disqus_thread"></div>
	<script type="text/javascript">
	    var disqus_shortname = '#disqusShortname#';
	    var disqus_identifier = '#stObj.objectid#';
	    var disqus_title = '#urlEncodedFormat(stObj.title)#';
	    var disqus_url = '#application.fc.lib.seo.getCanonicalURL(stObject=stObj)#';

	    (function() {
	        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
	        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
	        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	    })();
	</script>	
</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="false">