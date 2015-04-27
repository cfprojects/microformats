<!---
	Name         : microformats
	Author       : Tom Mollerus (tom@mollerus.net)
	Created      : April 20, 2007
	Last Updated : May 16, 2007
	Purpose		 : Provides functions for creating and reading microformats. See http://microformats.org/.
--->

<cfcomponent name="hCard" extends="microformats" output="no" hint="Provides functions to create and read hCard items.">
	<cffunction name="create" returntype="string" output="no">
		<cfargument name="prefix" type="string" required="no" default="">
		<cfargument name="givenName" type="string" required="no" default="">
		<cfargument name="additionalName" type="string" required="no" default="">
		<cfargument name="familyName" type="string" required="no" default="">
		<cfargument name="suffix" type="string" required="no" default="">
		<cfargument name="bday" type="date" required="no" default="">
		<cfargument name="URL" type="string" required="no" default="">
		<cfargument name="photo" type="string" required="no" default="">
		
		<cfargument name="adr" required="no" default="">
		<cfargument name="street" type="string" required="no" default="">
		<cfargument name="extended" type="string" required="no" default="">
		<cfargument name="locality" type="string" required="no" default="">
		<cfargument name="region" type="string" required="no" default="">
		<cfargument name="postalCode" type="string" required="no" default="">
		<cfargument name="country" type="string" required="no" default="">
		
		<cfargument name="geo" type="string" required="no" default="">
		<cfargument name="email" type="string" required="no" default="">
		<cfargument name="tel" required="no" default="">
		<cfargument name="telType" required="no" default="">
		<cfargument name="telLocation" required="no" default="">
		
		<cfargument name="org" type="string" required="no" default="">
		<cfargument name="role" type="string" required="no" default="">
		<cfargument name="logo" type="string" required="no" default="">
		<cfargument name="XHTMLDoc" type="string" required="no" default="">
		
		<!--- If no XHTML template is specified, and an organization is specified but not a first or last name --->
		<cfif not IsValidKey(ARGUMENTS, 'XHTMLDoc') and IsValidKey(ARGUMENTS, 'org') AND not (IsValidKey(ARGUMENTS, 'givenName') or IsValidKey(ARGUMENTS, 'additionalName'))>
			<cfset ARGUMENTS.XHTMLDoc = 'xhtml/hCard.org.cfm'><!--- Use the organizational template instead --->
		<cfelseif not IsValidKey(ARGUMENTS, 'XHTMLDoc')><!--- Else if no other XHTML template is specified --->
			<cfset ARGUMENTS.XHTMLDoc = 'xhtml/hCard.person.cfm'><!--- Use the personal template --->
		</cfif>
		
		<cfset VARIABLES.telTypeList = 'voice,home,msg,work,pref,fax,cell,video,pager,bbs,modem,car,isdn,pcs'>
		
		<cfsavecontent variable="VARIABLES.hCard"><cfinclude template="#ARGUMENTS.XHTMLDoc#"></cfsavecontent>
		
		<cfreturn VARIABLES.hCard>
	</cffunction>
	
	<cffunction name="hCardProxy" returnType="array" output="no">
		<cfargument name="URL" required="yes">
		<cfargument name="XSLTDoc" required="no" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#xslt/xhtml2vcard.xsl">
		<cfset var hCards = ''>
		
		<!--- Get the hCards --->
		<cfset hCards = getMicroformats(getFeed(ARGUMENTS.URL), 'hCard')>
		
		<!--- Get the XSLT document --->
		<cffile action="read" file="#ARGUMENTS.XSLTDoc#" variable="XSLTDoc">
		<cfset XSLTDoc = Replace(XSLTDoc, '[hCardSourceURL]', ARGUMENTS.URL)>
		
		<!--- For each of the hCards --->
		<cfloop index="index" from="1" to="#ArrayLen(hCards)#">
			<!--- Transform the hCard into a vCard with XSLT --->
			<cfif IsXML(hCards[index])>
				<cfset hCards[index] = XmlTransform(XMLParse(hCards[index]), XSLTDoc)>
			<cfelse>
				<cfset hCards[index] = '<!-- Not valid XML -->' & hCards[index]>
			</cfif>
		</cfloop>
		
		<!--- Return the vCard/s --->
		<cfreturn hCards>
	</cffunction>
</cfcomponent>