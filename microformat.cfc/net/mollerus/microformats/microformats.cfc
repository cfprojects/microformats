<!---
	Name         : microformats
	Author       : Tom Mollerus (tom@mollerus.net)
	Created      : April 20, 2007
	Last Updated : May 16, 2007
	Purpose		 : Provides functions for creating and reading microformats. See http://microformats.org/.
--->

<cfcomponent name="microformats" output="no" hint="Provides functions for creating and reading microformats. Authored by Tom Mollerus. See http://microformats.org/.">
	<cfset VARIABLES.version = 0.1>
	
	<cffunction name="getFeed" returntype="string" access="private" output="no" hint="Retrieves content from an URL.">
		<cfargument name="URL" type="string" required="yes" default="">
		
		<!--- If a proper URL is passed --->
		<cfif IsValid('URL', ARGUMENTS.URL)>
			<cfhttp url="#URL#" method="GET" resolveurl="false"></cfhttp>
			<cfreturn CFHTTP.fileContent>
		<cfelse>
			<cfreturn>
		</cfif>
		
	</cffunction>
	
	<cffunction name="getXML" output="no" access="private" hint="Loops through items for XSLT transformation">
		<cfargument name="items" required="yes">
		<cfargument name="sourceURL" type="string" required="yes">
		<cfargument name="xsltURL" type="string" required="yes">
		<cfset var XSLTDoc = ''>
		
		<!--- Get the XSLT document --->
		<cffile action="read" file="#ARGUMENTS.XSLTDoc#" variable="XSLTDoc">
		<cfset XSLTDoc = Replace(XSLTDoc, '[hSourceURL]', ARGUMENTS.sourceURL)>
		
		<!--- If an array of XML items has been passed --->
		<cfif IsArray(items)>
			<!--- For each of the XML items --->
			<cfloop index="index" from="1" to="#itemLength(items)#">
				<!--- Transform the items into rdf/xml with XSLT --->
				<cfset items[index] = transform(items[index], XSLTDoc)>
			</cfloop>
		<cfelse>
			<cfset items = Transform(items, XSLTDoc)>
		</cfif>
		
		<cfreturn hReviews>
	</cffunction>
	
	<cffunction name="Transform" access="private" output="no" hint="Transforms a string into XML">
		<cfargument name="item" type="string" required="yes">
		<cfargument name="XSLTDoc" type="string" required="yes">
		
		<cfif IsXML(item)>
			<cfset item = XmlTransform(XMLParse(item), XSLTDoc)>
		<cfelse>
			<cfset item = '<!-- Not valid XML -->' & item>
		</cfif>
		
		<cfreturn item>
	</cffunction>
	
	<cffunction name="getMicroformats" returnType="array" access="private" output="yes" hint="Returns all the regexp matches of a specified microformat from a string.">
		<cfargument name="string" type="string" required="true">
		<cfargument name="microformat" type="string" required="true">

		<cfset var aResults = arrayNew(1)>
		<cfset var matches = ''>
		<cfset var class = ''>
		<cfset var thisType = ''>
		<cfset var thisString = ''>
		<cfset var nextMatch = ''>
		<cfset var nextTag = ''>
		<cfset var nestLevel = 1>
		<cfset var currentMatchPos = 1>
		<cfset var currentTagPos = 1>
		
		<!--- Select the correct XHTML class to look for --->
		<cfswitch expression="#ARGUMENTS.microformat#">
			<cfcase value="hAtom"><cfset class='hEntry'></cfcase>
			<cfcase value="hCal,hCalendar"><cfset class='vEvent'></cfcase>
			<cfcase value="hCard"><cfset class='vCard'></cfcase>
			<cfcase value="hReview"><cfset class='hreview'></cfcase>
			<cfdefaultcase><cfset class = ARGUMENTS.microformat></cfdefaultcase>
		</cfswitch>
		
		<!--- Find all the matches for the class --->
		<cfset nextMatch = REFindNoCase('<[^>]*class="[^"]+ ?#class# ?[^"]+"[^>]*?>', ARGUMENTS.string, currentMatchPos, 1)><cfdump var="#nextMatch#" label="nextMATCH">
		<cfloop condition="nextMatch.pos[1] gt 0"><!--- For each of the matches --->
			<!--- Get the name of the start tag --->
			<cfset thisString = Mid(ARGUMENTS.string, nextMatch.pos[1], Len(ARGUMENTS.string))>
			<cfset thisType = ReReplaceNoCase(thisString, '^<([[:alpha:]]+)[[:space:]].*', '\1')>
			<!--- Get the next tag --->
			<cfset nestLevel = 1>
			<cfset currentTagPos = 1>
			<cfset nextTag = REFindNoCase('</?#thisType#', thisString, Max(2, currentTagPos), 1)>
			<cfloop condition="nextTag.pos[1] gt 0 and nestLevel gt 0">
				<cfset nextTag = REFindNoCase('</?#thisType#', thisString, Max(2, currentTagPos), 1)>
				<cfif nextTag.pos[1] gt 0>
					<cfif Mid(thisString, nextTag.pos[1], nextTag.len[1]) eq '</#thisType#'>
						<cfset nestLevel = nestLevel - 1>
					<cfelse>
						<cfset nestLevel = nestLevel + 1>
					</cfif>
					<cfset currentTagPos = nextTag.pos[1] + nextTag.len[1]>
				</cfif>
			</cfloop>
			<cfif nextTag.pos[1] gt 0>
			 	<cfset aResults[ArrayLen(aResults) + 1] = Mid(ARGUMENTS.string, nextMatch.pos[1], currentTagPos)>
			</cfif>
			<cfset currentMatchPos = nextMatch.pos[1] + nextTag.pos[1] + nextTag.len[1]>
			<cfset nextMatch = REFindNoCase('<[^>]*class="[^"]+ ?#class# ?[^"]+"[^>]*?>', ARGUMENTS.string, currentMatchPos, 1)>
		</cfloop>
		
		<!--- Escape any ampersands in the results --->
		<cfloop index="index" from="1" to="#ArrayLen(aResults)#">
			<cfset aResults[index] = ReReplace(aResults[index], '&', '&amp;', 'ALL') />
		</cfloop>
		
		<cfreturn aResults>
	</cffunction>
	
	<cffunction name="IsValidKey" returntype="boolean" access="private" output="no" hint="Checks whether a structure key exists, whether it is empty, and whether it is in a specified format.">
		<cfargument name="struct" type="struct" required="yes">
		<cfargument name="key" type="string" required="yes">
		<cfargument name="type" type="string" required="no" default="">
		<cfset var bValidKey = 1>
		
		<cfif not StructKeyExists(struct, key)>
			<cfset bValidKey = 0>
		<cfelseif struct[key] eq ''>
			<cfset bValidKey = 0>
		<cfelseif ARGUMENTS.type neq '' and not IsValid(type, struct[key])>
			<cfset bValidKey = 0>
		</cfif>
		
		<cfreturn bValidKey>
	</cffunction>
</cfcomponent>