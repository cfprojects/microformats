<cfoutput><div class="hreview">
    <h2 class="item">Review: <cfif IsValidKey(ARGUMENTS, 'URL', 'URL')><a href="#ARGUMENTS.URL#" class="fn url">#ARGUMENTS.item#</a><cfelse>#ARGUMENTS.item#</cfif></h2>
	
	<p><cfif IsValidKey(ARGUMENTS, 'summary')><em class="summary">#ARGUMENTS.summary#</em><br /></cfif>
    <cfif IsValidKey(ARGUMENTS, 'reviewer')><span class="reviewer vcard">By <span class="fn">#ARGUMENTS.reviewer#</span></span></cfif>
	<cfif IsValidKey(ARGUMENTS, 'date', 'date')>, reviewed on <abbr title="#DateFormat(ARGUMENTS.date, 'yyyymmdd')#" class="dtreviewed">#DateFormat(ARGUMENTS.date, 'dddd, mmmm d, yyyy')#</abbr>.</cfif><br />
	<cfif IsValidKey(ARGUMENTS, 'rating')>Rating: <span class="rating"><span class="value">#ARGUMENTS.rating#</span><cfif IsValidKey(ARGUMENTS, 'ratingBest')> out of <span class="best">#ARGUMENTS.ratingBest#</span></cfif></p></cfif>
	<cfif IsValidKey(ARGUMENTS, 'description')><div class="description">#ARGUMENTS.description#</div></cfif>
	<cfif IsValidKey(ARGUMENTS, 'type')><p>Review type: <span class="type">#ARGUMENTS.type#</span></p></cfif>
	<cfif IsValidKey(ARGUMENTS, 'license')><p>#ARGUMENTS.license#</p></cfif>
</div></cfoutput>