<cfoutput><div class="vevent">
    <div class="summary"><cfif IsValidKey(ARGUMENTS, 'URL', 'URL')><a href="#ARGUMENTS.URL#" class="url">#ARGUMENTS.summary#</a><cfelse>#ARGUMENTS.summary#</cfif></div>
   
   <cfif IsValidKey(ARGUMENTS, 'description')><div class="description">
        #ARGUMENTS.description#
	</div></cfif>
	<p><cfif IsValidKey(ARGUMENTS, 'end', 'date')>From<cfelse>On</cfif> <abbr title="#DateFormat(ARGUMENTS.start, 'yyyymmdd')#T#TimeFormat(ARGUMENTS.start, 'HH:mm:ss')#<cfif IsValidKey(ARGUMENTS, 'timezone')>#ARGUMENTS.timezone#</cfif>" class="dtstart">#DateFormat(ARGUMENTS.start, 'dddd, mmmm d, yyyy')# #TimeFormat(ARGUMENTS.start, 'hh:mmtt')#</abbr><cfif IsValidKey(ARGUMENTS, 'end', 'date')> to <abbr title="#DateFormat(ARGUMENTS.end, 'yyyymmdd')##TimeFormat(ARGUMENTS.end, 'HH:mm:ss')#<cfif IsValidKey(ARGUMENTS, 'timezone')>T#ARGUMENTS.timezone#</cfif>" class="dtstart">#DateFormat(ARGUMENTS.end, 'dddd, mmmm d, yyyy')# #TimeFormat(ARGUMENTS.end, 'hh:mmtt')#</abbr></cfif></p>
	<cfif IsValidKey(ARGUMENTS, 'location')><p class="location">#ARGUMENTS.location#</p></cfif>
</div></cfoutput>