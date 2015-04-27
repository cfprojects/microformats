<!---
	Name         : microformats
	Author       : Tom Mollerus (tom@mollerus.net)
	Created      : April 20, 2007
	Last Updated : May 16, 2007
	Purpose		 : Provides functions for creating and reading microformats. See http://microformats.org/.
--->

<cfcomponent name="hReview" extends="microformats" output="no" hint="Provides functions to create and read hReview items.">
	<cffunction name="create" returntype="string" output="no">
		<cfargument name="item" type="string" required="yes">
		<cfargument name="summary" type="string" required="no" default="">
		<cfargument name="type" type="string" required="no" default="">
		<cfargument name="reviewer" type="string" required="no" default="">
		<cfargument name="date" type="date" required="no" default="">
		<cfargument name="URL" type="string" required="no" default="">
		<cfargument name="rating" type="numeric" required="no" default="">
		<cfargument name="ratingBest" type="numeric" required="no" default="">
		<cfargument name="license" type="string" required="no" default='<a href="http://creativecommons.org/licenses/by-sa/2.5/" rel="license">Licensed under a creative commons attribution share alike 2.5 license</a>'>
		<cfargument name="XHTMLDoc" type="string" required="no" default="xhtml/hReview.cfm">
		
		<cfsavecontent variable="VARIABLES.hReview"><cfinclude template="#ARGUMENTS.XHTMLDoc#"></cfsavecontent>
		
		<cfreturn VARIABLES.hReview>
	</cffunction>
	
	<cffunction name="hReviewProxy" returnType="array" output="no">
		<cfargument name="URL" type="string" required="yes">
		<cfargument name="format" type="string" required="no" default="XHTML">
		<cfargument name="XSLTDoc" required="no" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#xslt/hreview2rdfxml.xsl">
		<cfset var hReviews = ''>
		
		<!--- Get the hReviews --->
		<cfset hReviews = getMicroformats(getFeed(ARGUMENTS.URL), 'hReview')>
		
		<!--- Return the review/s --->
		<cfif ARGUMENTS.format eq 'XML'>
			<cfreturn getXML(hReviews, ARGUMENTS.URL)>
		<cfelse>
			<cfreturn hReviews>
		</cfif>
	</cffunction>
</cfcomponent>