<!---
	Name         : microformats
	Author       : Tom Mollerus (tom@mollerus.net)
	Created      : April 20, 2007
	Last Updated : May 16, 2007
	Purpose		 : Provides functions for creating and reading microformats. See http://microformats.org/.
--->

<cfcomponent name="hCalendar" extends="microformats" output="no" hint="Provides functions to create and read hCalendar items.">
	<cffunction name="create" returntype="string" output="no">
		<cfargument name="summary" type="string" required="yes">
		<cfargument name="location" required="no" default="">
		<cfargument name="URL" type="string" required="no" default="">
		<cfargument name="start" type="date" required="yes">
		<cfargument name="end" type="date" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="timezone" type="string" required="no" default="-0:00">
		<cfargument name="XHTMLDoc" type="string" required="no" default="xhtml/hCal.cfm">
		
		<cfsavecontent variable="VARIABLES.hCalendar"><cfinclude template="#ARGUMENTS.XHTMLDoc#"></cfsavecontent>
		
		<cfreturn VARIABLES.hCalendar>
	</cffunction>
	
	<cffunction name="hCalProxy" returnType="array" output="no">
		<cfargument name="URL" required="yes">
		<cfargument name="XSLTDoc" required="no" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#xslt/xhtml2vcal.xsl">
		<cfset var hCals = ''>
		
		<!--- Get the hCals --->
		<cfset hCals = getMicroformats(getFeed(ARGUMENTS.URL), 'hCal')>
		
		<!--- Get the XSLT document --->
		<cffile action="read" file="#ARGUMENTS.XSLTDoc#" variable="XSLTDoc">
		<cfset XSLTDoc = Replace(XSLTDoc, '[hCalSourceURL]', ARGUMENTS.URL)>
		
		<!--- For each of the hCals --->
		<cfloop index="index" from="1" to="#ArrayLen(hCals)#">
			<!--- Transform the hCal into a vCal with XSLT --->
			<cfif IsXML(hCals[index])>
				<cfset hCals[index] = XmlTransform(XMLParse(hCals[index]), XSLTDoc)>
			<cfelse>
				<cfset hCals[index] = '<!-- Not valid XML -->' & hCals[index]>
			</cfif>
		</cfloop>
		
		<!--- Return the vCal/s --->
		<cfreturn hCals>
	</cffunction>
</cfcomponent>