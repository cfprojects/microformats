<cfoutput><div class="vcard">
    <cfif IsValidKey(ARGUMENTS, 'logo')><img src="#ARGUMENTS.logo#" border="0" alt="" align="left" style="padding-right: 10px;" /></cfif><span class="fn org">#ARGUMENTS.org#</span>
   
	<cfif IsValidKey(ARGUMENTS, 'adr')><cfif IsStruct(ARGUMENTS.adr)><cfloop item="key" collection="#ARGUMENTS.tel#"><div class="adr">
		<cfif IsValidKey(ARGUMENTS.adr[key], 'street')><span class="street-address">#ARGUMENTS.adr[key].street#</span><br /></cfif>
		<cfif IsValidKey(ARGUMENTS.adr[key], 'extended')><span class="extended-address">#ARGUMENTS.adr[key].extended#</span><br /></cfif>
		<cfif IsValidKey(ARGUMENTS.adr[key], 'locality')><span class="locality">#ARGUMENTS.adr[key].locality#</span>, </cfif><cfif IsValidKey(ARGUMENTS.adr[key], 'region')><span class="region">#ARGUMENTS.adr[key].region#</span> </cfif><cfif IsValidKey(ARGUMENTS.adr[key], 'postalCode')><span class="postal-code">#ARGUMENTS.adr[key].postalCode#</span></cfif><cfif IsValidKey(ARGUMENTS.adr[key], 'locality') or IsValidKey(ARGUMENTS.adr[key], 'region') or IsValidKey(ARGUMENTS.adr[key], 'postalCode')><br /></cfif>
		<cfif IsValidKey(ARGUMENTS.adr[key], 'country')><span class="country-name">#ARGUMENTS.adr[key].country#</span></cfif>
	</div></cfloop><cfelse><div class="adr">
		<cfif IsValidKey(ARGUMENTS, 'street')><span class="street-address">#ARGUMENTS.street#</span><br /></cfif>
		<cfif IsValidKey(ARGUMENTS, 'extended')><span class="extended-address">#ARGUMENTS.extended#</span><br /></cfif>
		<cfif IsValidKey(ARGUMENTS, 'locality')><span class="locality">#ARGUMENTS.locality#</span>, </cfif><cfif IsValidKey(ARGUMENTS, 'region')><span class="region">#ARGUMENTS.region#</span> </cfif><cfif IsValidKey(ARGUMENTS, 'postalCode')><span class="postal-code">#ARGUMENTS.postalCode#</span></cfif><cfif IsValidKey(ARGUMENTS, 'locality') or IsValidKey(ARGUMENTS, 'region') or IsValidKey(ARGUMENTS, 'postalCode')><br /></cfif>
		<cfif IsValidKey(ARGUMENTS, 'country')><span class="country-name">#ARGUMENTS.country#</span></cfif>
	</div></cfif></cfif>

	<p><cfif IsValidKey(ARGUMENTS, 'tel')><cfif IsStruct(ARGUMENTS.tel)><cfloop item="key" collection="#ARGUMENTS.tel#">#ARGUMENTS.tel[key].type#: <span class="tel"><span class="#ARGUMENTS.tel[key].type#">##ARGUMENTS.tel[key].location#</span>: <span class="value">#ARGUMENTS.tel[key].value#</span><br /></cfloop><cfelse>#ARGUMENTS.telType#: <span class="tel"><span class="#ARGUMENTS.telType#">##ARGUMENTS.telLocation#</span>: <span class="value">#ARGUMENTS.tel#</span><br /></cfif></cfif>
	<cfif IsValidKey(ARGUMENTS, 'email', 'email')>Email: <a href="mailto:#ARGUMENTS.email#" class="email">#ARGUMENTS.email#</a><br /></cfif>
	<cfif IsValidKey(ARGUMENTS, 'URL', 'URL')>URL: <a href="#ARGUMENTS.URL#" class="url">#ARGUMENTS.URL#</a></cfif></p>
</div></cfoutput>