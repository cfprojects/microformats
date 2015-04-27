<cfif IsStruct(thisAdr)>
	<div class="adr">
		<cfif Len(thisAdr.type)><span class="type">#thisAdr.type#:</span><br /></cfif>
		<cfif Len(thisAdr.street)><span class="street-address">#thisAdr.street#</span><br /></cfif>
		<cfif Len(thisAdr.extended)><span class="extended-address">#thisAdr.extended#</span><br /></cfif>
		<cfif Len(thisAdr.locality)><span class="locality">#thisAdr.locality#</span></cfif><cfif Len(thisAdr.region) or Len(thisAdr.postalCode)>,</cfif><cfif Len(thisAdr.region)> <span class="region">#thisAdr.region#</span></cfif><cfif Len(thisAdr.postalCode)> <span class="postal-code">#thisAdr.postalCode#</span></cfif><cfif Len(thisAdr.locality) or Len(thisAdr.region) or Len(thisAdr.postalCode)><br /></cfif>
		<cfif Len(thisAdr.country)><span class="country-name">#thisAdr.country#</span></cfif>
	</div>
</cfif>