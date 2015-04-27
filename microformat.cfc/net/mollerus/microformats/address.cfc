<cfcomponent name="address" output="no">
	<cffunction name="init" returntype="string">
		<!--- <cfargument name="stAddress" type="struct" required="no"> --->
		<cfargument name="type" type="string" required="no" default="">
		<cfargument name="poBox" type="string" required="no" default="">
		<cfargument name="street" type="string" required="no" default="">
		<cfargument name="extended" type="string" required="no" default="">
		<cfargument name="locality" type="string" required="no" default="">
		<cfargument name="region" type="string" required="no" default="">
		<cfargument name="postalCode" type="string" required="no" default="">
		<cfargument name="country" type="string" required="no" default="">
		
		<cfset VARIABLES.adr = StructNew()>
		<cfset VARIABLES.adr.type = ARGUMENTS.type>
		<cfset VARIABLES.adr.poBox = ARGUMENTS.poBox>
		<cfset VARIABLES.adr.street = ARGUMENTS.street>
		<cfset VARIABLES.adr.extended = ARGUMENTS.extended>
		<cfset VARIABLES.adr.locality = ARGUMENTS.locality>
		<cfset VARIABLES.adr.region = ARGUMENTS.region>
		<cfset VARIABLES.adr.postalCode = ARGUMENTS.postalCode>
		<cfset VARIABLES.adr.countryName = ARGUMENTS.country>
		<cfif not ListFindNoCase('work,home,pref,postal,dom,intl', ARGUMENTS.type)>
			<cfset VARIABLES.adr.type = ''>
		</cfif>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getXHTML" returntype="string">
		<cfargument name="adr" type="struct" required="no" default="">
		<cfargument name="XHTMLDoc" type="string" required="no" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#xhtml/adr.cfm">
		<cfset var thisAdr>
		
		<cfsavecontent variable="VARIABLES.XHTML"><cfinclude template="#ARGUMENTS.XHTMLDoc#"></cfsavecontent>
		
		<cfreturn VARIABLES.XHTML>
	</cffunction>
</cfcomponent>