<cfcomponent name="geo" output="no">
	<cffunction name="init" returntype="string">
		<!--- <cfargument name="stAddress" type="struct" required="no"> --->
		<cfargument name="lon" type="numeric" required="yes" default="">
		<cfargument name="lat" type="numeric" required="yes" default="">
		<cfargument name="description" type="string" required="no">
		
		<cfset VARIABLES.geo = StructNew()>
		<cfset VARIABLES.geo.lon = ARGUMENTS.lon>
		<cfset VARIABLES.geo.lat = ARGUMENTS.lat>
		<cfset VARIABLES.geo.description = ARGUMENTS.description>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getXHTML" returntype="string">
		<cfsavecontent variable="VARIABLES.XHTML"><cfoutput><span class="geo"><span class="latitude">#VARIABLES.geo.lat#</span>, <span class="longitude">#VARIABLES.geo.lon#</span></span></cfoutput></cfsavecontent>
		
		<cfreturn VARIABLES.XHTML>
	</cffunction>
	
	<cffunction name="getXHTMLAbbr" returntype="string">
		<cfargument name="description" type="string" required="no" default="">
		
		<cfsavecontent variable="VARIABLES.XHTML"><cfoutput><abbr title="#VARIABLES.geo.lat#;#VARIABLES.geo.lon#" class="geo"><cfif Len(Trim(ARGUMENTS.description))>#ARGUMENTS.description#<cfelse>#VARIABLES.geo.description#</cfif></abbr></cfoutput></cfsavecontent>
		
		<cfreturn VARIABLES.XHTML>
	</cffunction>
</cfcomponent>