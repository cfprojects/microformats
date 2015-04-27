<cfcomponent name="hAtom" extends="microformats" output="no" hint="Provides functions to create and read hAtom feeds.">
	<cffunction name="create" returntype="string" output="no">
		<cfargument name="title" type="string" required="yes">
		<cfargument name="author" type="string" required="yes">
		<cfargument name="updated" type="date" required="yes">
		<cfargument name="summary" type="string" required="no" default="">
		<cfargument name="content" type="string" required="no" default="">
		<cfargument name="published" type="date" required="no" default="">
		<cfargument name="categories" type="struct" required="no" default="">
		<cfargument name="XHTMLDoc" type="string" required="no" default="xhtml/hAtom.cfm">
		
		<cfsavecontent variable="VARIABLES.hAtom"><cfinclude template="#ARGUMENTS.XHTMLDoc#"></cfsavecontent>
		
		<cfreturn VARIABLES.hAtom>
	</cffunction>
	
	<cffunction name="hAtomProxy" returnType="array" output="no">
		<cfargument name="URL" required="yes">
		<cfargument name="XSLTDoc" required="no" default="#GetDirectoryFromPath(GetCurrentTemplatePath())#xslt/hAtom2Atom.xsl">
		<cfset var hAtoms = ''>
		
		<!--- Get the hAtoms --->
		<cfset hAtoms = getMicroformats(getFeed(ARGUMENTS.URL), 'hAtom')>
		
		<!--- Get the XSLT document --->
		<cffile action="read" file="#ARGUMENTS.XSLTDoc#" variable="XSLTDoc">
		<cfset XSLTDoc = Replace(XSLTDoc, '[hAtomSourceURL]', ARGUMENTS.URL)>
		
		<!--- For each of the hAtoms --->
		<cfloop index="index" from="1" to="#ArrayLen(hAtoms)#">
			<!--- Transform the hAtom into Atom with XSLT --->
			<cfif isXML(hAtoms[index])>
				<cfset hAtoms[index] = XmlTransform(XMLParse(hAtoms[index]), XSLTDoc)>
			<cfelse>
				<cfset hAtoms[index] = '<!-- Not valid XML -->' & hAtoms[index]>
			</cfif>
		</cfloop>
		
		<!--- Return the Atom/s --->
		<cfreturn hAtoms>
	</cffunction>
</cfcomponent>