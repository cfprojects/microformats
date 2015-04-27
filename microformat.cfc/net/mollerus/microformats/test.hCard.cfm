<cfsetting enablecfoutputonly="yes">

<!--- Initialize parameters --->
<cfparam name="FORM.URL2" default="http://www.w3.org/People/Connolly/events/">
<cfparam name="FORM.bDump" default="0">
<cfparam name="FORM.givenName" default="">
<cfparam name="FORM.additionalName" default="">
<cfparam name="FORM.familyName" default="">
<cfparam name="FORM.startMonth" default="01">
<cfparam name="FORM.startDay" default="01">
<cfparam name="FORM.startYear" default="">
<cfparam name="FORM.role" default="">
<cfparam name="FORM.org" default="">
<cfparam name="FORM.street" default="">
<cfparam name="FORM.city" default="">
<cfparam name="FORM.region" default="">
<cfparam name="FORM.postalCode" default="">
<cfparam name="FORM.country" default="">
<cfparam name="FORM.tellocation" default="">
<cfparam name="FORM.teltype" default="">
<cfparam name="FORM.tel" default="">
<cfparam name="FORM.URL" default="http://">
<cfparam name="FORM.photo" default="http://">
<cfparam name="FORM.email" default="">

<!--- If the form was submitted --->
<cfif IsDefined("FORM.get") and IsValid('URL', FORM.URL2)>
	<cfset vCards = CreateObject('component', 'net.mollerus.microformats.hCard').hCardProxy('#FORM.URL2#')>
	
	<!--- If the information should be dumped --->
	<cfif Val(FORM.bDump)>
		<cfdump var="#vCards#">
	<cfelse><!--- Else send the information down as vCards --->
		<cfcontent type="text/x-vCard">
		<cfheader name="Content-Disposition" value="inline; filename=vcard.vcf">
<cfoutput><cfloop index="index" from="1" to="#ArrayLen(vCards)#">#vCards[index]#

</cfloop></cfoutput>
	</cfif>
<cfelse><!--- Else show the form --->

	<cfif IsDefined("FORM.create")><!--- Else if an hCard is requested --->
		<cfset FORM.bDay = CreateDate(FORM.startyear, FORM.startmonth, FORM.startday)>
		<cfset VARIABLES.hCard = CreateObject('component', 'net.mollerus.microformats.hCard').create(argumentCollection = FORM)>
	</cfif>


<cfsetting enablecfoutputonly="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

<head>
<title>hCalender Test for net.mollerus.microformats.hCalendar</title>
<style type="text/css">
	/*<![CDATA[*/
	label { float:left; clear:left; text-align:right; width:5em; padding-right:.2em; font-weight:bold; line-height:1.9em }
	div.field { margin-bottom:.2em; font-size:smaller }
	div.field input { width: 16em; }
	div.field span.note {font-size:90%;}
	div.submit { margin:1em 0 1em 7em }
	.submit button,.submit input { margin-left:1em }
	div.inputs { width:25em; float:left; margin-right:2em }
	form,fieldset { margin:0 }
	h2 { margin:.3em 0 .1em 0; font-size:1em }
	div.output { float:left }
	div#preview { padding:.5em; background:#ccc; border:1px solid black; margin-right:2em }
	div.about { clear:both; padding-top:4em }
	#startHour,#startMinute,#endHour,#endMinute {width:2em}
	#timezone {width:10em}
	#previewblock{clear:left}
	#summary, #location, #url {width:21em}
	/*]]>*/
</style>
</head>

<body>
<h2>Test <a href="http://microformats.org/wiki/hcard">hCard</a></h2>

	<p><cfoutput>
	<div class="inputs">
	<form action="#CGI.SCRIPT_NAME#" method="post">
	<fieldset><legend>Get vCards from hCards</legend>
	<div class="field">
		<label for="URL2">URL:</label>
		<input type="text" name="URL2" value="#FORM.URL2#" size="50">
	</div>
	<div class="field">
		<label for="bDump">Dump&nbsp;data:</label>
		<input type="checkbox" name="bDump" value="1"<cfif Val(FORM.bDump)> checked</cfif>>
	</div>
	<div class="submit">
		<input type="submit" name="get" value="Get vCards">
	</div>
	</fieldset>
	</form>
	</div></p>
	
	<br clear="both" />
	
<div class="inputs">
<form action="#CGI.SCRIPT_NAME#" method="post">
 <fieldset><legend>Create hCard</legend>

 <div class="field">
  <label for="givenname">given&nbsp;name</label>
  <input type="text" id="givenname" name="givenName" value="#FORM.givenName#" />
 </div>
 <div class="field">
  <label for="additionalname">middle&nbsp;name</label>
  <input type="text" id="additionalName" name="additionalName" value="#FORM.additionalName#" />
 </div>
 <div class="field">
  <label for="familyname">family&nbsp;name</label>
  <input type="text" id="familyname" name="familyName" value="#FORM.familyName#" />
 </div>

 <div class="field">
    <label for="startMonth">Birthday</label>
    <select name="startMonth" id="startMonth" ><cfloop index="index" from="1" to="12">
        <option value="#index#"<cfif FORM.startMonth eq index> selected</cfif>>#MonthAsString(index)#</option></cfloop>
    </select>
    <select name="startDay" id="startDay" ><cfloop index="index" from="1" to="31">
        <option value="#index#"<cfif FORM.startDay eq index> selected</cfif>>#index#</option></cfloop>
    </select>
    <select name="startYear" id="startYear" ><cfloop index="index" from="#Year(Now())#" to="#Year(Now()) - 100#" step="-1">
        <option value="#index#"<cfif FORM.startYear eq index> selected</cfif>>#index#</option></cfloop>
    </select>
 </div>

 <div class="field">
  <label for="role">title</label>
  <input type="text" id="role" name="role" value="#FORM.role#" /> 
 </div>
 <div class="field">
  <label for="org">organization</label>
  <input type="text" id="org" name="org" value="#FORM.org#" /> 
 </div>
 <div class="field">
  <label for="street">street</label>
  <input type="text" id="street" name="street" value="#FORM.street#" />
 </div>
 <div class="field">
  <label for="city">city</label>
  <input type="text" id="city" name="city" value="#FORM.city#" />
 </div>
 <div class="field">
  <label for="region">state/province</label>
  <input type="text" id="region" name="region" value="#FORM.region#" />
 </div>
 <div class="field">
  <label for="postal">postal&nbsp;code</label>
  <input type="text" id="postal" name="postalCode" value="#FORM.postalCode#" />
 </div>
 <div class="field">  
  <label for="country">country</label>
  <input type="text" id="country" name="country" value="#FORM.country#" />
 </div>
 <div class="field">
  <label for="phone">phone</label>
  <select name="tellocation"><cfloop index="index" list="Home,Work">
        <option value="#index#"<cfif FORM.tellocation eq index> selected</cfif>>#index#</option></cfloop>
  </select>
  <select name="teltype"><cfloop index="index" list="Landline,Cell,Fax,Pager">
        <option value="#index#"<cfif FORM.teltype eq index> selected</cfif>>#index#</option></cfloop>
  </select>
  <input type="text" id="tel" name="tel" value="#FORM.tel#" />
 </div>
 <div class="field">
  <label for="email">email</label>
  <input type="text" id="email" name="email" value="#FORM.email#" /> 
 </div>
 <div class="field">
  <label for="url">url</label>
  <input type="text" id="url" name="URL" value="#FORM.URL#" /> 
 </div>
 <div class="field">
  <label for="photo">photo url</label>
  <input type="text" id="photo" name="photo" value="#FORM.photo#" /> 
 </div><!--- 
 <div class="field">
  <label for="aim"><abbr title="AOL Instant Messenger">AIM</abbr> screenname</label>
  <input type="text" id="aim" /> 
 </div>
 <div class="field">
  <label for="yim"><abbr title="Yahoo Instant Messenger">YIM</abbr> screenname</label>
  <input type="text" id="yim" /> 
 </div>
 <div class="field">
  <label for="tags">tags (comma separated)</label>
  <input type="text" id="tags" />
 </div> --->

 <div class="submit">
   <input type="submit" name="create" value="Create">
   <input type="reset" value="Reset">
 </div>
 </fieldset>
</form>
</div>

	<div class="output">
	<h2>Preview code</h2>
	<textarea id="samplecode" rows="18" cols="50"><cfif IsDefined("VARIABLES.hCard")>#HTMLEditFormat(VARIABLES.hCard)#</cfif></textarea>
	</div>
	
	<div id="previewblock">
		<h2>Preview output</h2>
		<div id="preview">
		<span><cfif IsDefined("VARIABLES.hCard")>#VARIABLES.hCard#</cfif></span>
		</div>
	</div>
</cfoutput>
	

</body>

</html>

</cfif>
