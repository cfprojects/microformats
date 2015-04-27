<cfsetting enablecfoutputonly="yes">

<!--- Initialize parameters --->
<cfparam name="FORM.URL2" default="http://www.w3.org/People/Connolly/events/">
<cfparam name="FORM.bDump" default="0">
<cfparam name="FORM.summary" default="Event title">
<cfparam name="FORM.location" default="">
<cfparam name="FORM.URL" default="http://">
<cfparam name="FORM.startMonth" default="01">
<cfparam name="FORM.startDay" default="01">
<cfparam name="FORM.startYear" default="#Year(Now())#">
<cfparam name="FORM.startHour" default="">
<cfparam name="FORM.startMinute" default="">
<cfparam name="FORM.endMonth" default="01">
<cfparam name="FORM.endDay" default="01">
<cfparam name="FORM.endYear" default="#Year(Now())#">
<cfparam name="FORM.endHour" default="">
<cfparam name="FORM.endMinute" default="">
<cfparam name="FORM.description" default="">
<cfparam name="FORM.tags" default="">

<!--- If the form was submitted --->
<cfif IsDefined("FORM.get") and IsValid('URL', FORM.URL2)>
	<cfset vCards = CreateObject('component', 'net.mollerus.microformats.hCalendar').hCalProxy('#FORM.URL2#')>
	
	<!--- If the information should be dumped --->
	<cfif Val(FORM.bDump)>
		<cfdump var="#vCards#">
	<cfelse><!--- Else send the information down as vCards --->
		<cfcontent type="text/x-vCalendar">
		<cfheader name="Content-Disposition" value="inline; filename=vcal.vcs">
<cfoutput><cfloop index="index" from="1" to="#ArrayLen(vCards)#">#vCards[index]#

</cfloop></cfoutput>
	</cfif>
<cfelse><!--- Else show the form --->

<cfif IsDefined("FORM.create")><!--- Else if an hCard is requested --->
	<cfif Val(FORM.startHour)>
		<cfset FORM.start = CreateDateTime(FORM.startyear, FORM.startmonth, FORM.startday, FORM.starthour, FORM.startminute, 0)>
	<cfelse>
		<cfset FORM.start = CreateDate(FORM.startyear, FORM.startmonth, FORM.startday)>
	</cfif>
	<cfif Val(FORM.endHour)>
		<cfset FORM.end = CreateDateTime(FORM.endyear, FORM.endmonth, FORM.endday, FORM.endhour, FORM.endminute, 0)>
	<cfelse>
		<cfset FORM.end = CreateDate(FORM.endyear, FORM.endmonth, FORM.endday)>
	</cfif>
	<cfset VARIABLES.hCalendar = CreateObject('component', 'net.mollerus.microformats.hCalendar').create(argumentCollection = FORM)>
</cfif>

<cfsetting enablecfoutputonly="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

<head>
<title>hCalendar Test for net.mollerus.microformats.hCalendar</title>
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
<h2>Test <a href="http://microformats.org/wiki/hcalendar">hCalendar</a></h2>

	<p><cfoutput>
	<div class="inputs">
	<form action="#CGI.SCRIPT_NAME#" method="post">
	<fieldset><legend>Get vCalendars from hCalendars</legend>
	<div class="field">
		<label for="URL2">URL:</label>
		<input type="text" name="URL2" value="#FORM.URL2#" size="50">
	</div>
	<div class="field">
		<label for="bDump">Dump&nbsp;data:</label>
		<input type="checkbox" name="bDump" value="1"<cfif Val(FORM.bDump)> checked</cfif>>
	</div>
	<div class="submit">
		<input type="submit" name="get" value="Get vCals">
	</div>
	</fieldset>
	</form>
	</div></p>
	
	<br clear="both" />
	<div class="inputs">
<form action="#CGI.SCRIPT_NAME#" method="post">
 <fieldset><legend>Create hCalendar</legend>
 <!-- url, summary, dtstart, dtend, location -->
 <div class="field">
   <label for="summary">summary</label>
   <input type="text" name="summary" id="summary" value="#FORM.summary#" />
 </div>
 <div class="field">
   <label for="location">location</label>
   <input type="text" name="location" id="location" value="#FORM.location#" />
 </div>
 <div class="field">
   <label for="url">url</label>
   <input type="text" name="url" id="url" value="#FORM.url#"/> 
 </div>

 <div class="field">
    <label for="startMonth">start</label>
    <select name="startMonth" id="startMonth" ><cfloop index="index" from="1" to="12">
        <option value="#index#"<cfif FORM.startMonth eq index> selected</cfif>>#MonthAsString(index)#</option></cfloop>
    </select>
    <select name="startDay" id="startDay" ><cfloop index="index" from="1" to="31">
        <option value="#index#"<cfif FORM.startDay eq index> selected</cfif>>#index#</option></cfloop>
    </select>
    <select name="startYear" id="startYear" ><cfloop index="index" from="#Year(Now())#" to="#Year(Now()) + 6#">
        <option value="#index#"<cfif FORM.startYear eq index> selected</cfif>>#index#</option></cfloop>
    </select>
    <input type="text" name="startHour" id="startHour" value="#FORM.startHour#" maxlength="2" /> :
    <input type="text" name="startMinute" id="startMinute" value="#FORM.startMinute#" maxlength="2" />
 </div>

 <div class="field">
    <label for="endMonth">end</label>
    <select name="endMonth" id="endMonth" ><cfloop index="index" from="1" to="12">
        <option value="#index#"<cfif FORM.endMonth eq index> selected</cfif>>#MonthAsString(index)#</option></cfloop>
    </select>
    <select name="endDay" id="endDay" ><cfloop index="index" from="1" to="31">
        <option value="#index#"<cfif FORM.endDay eq index> selected</cfif>>#index#</option></cfloop>
    </select>
    <select name="endYear" id="endYear"><cfloop index="index" from="#Year(Now())#" to="#Year(Now()) + 6#">
        <option value="#index#"<cfif FORM.endYear eq index> selected</cfif>>#index#</option></cfloop>
    </select>
    <input type="text" name="endHour" id="endHour" value="#FORM.endHour#" maxlength="2" /> :
    <input type="text" name="endMinute" id="endMinute" value="#FORM.endMinute#" maxlength="2" />
 </div>
 <div class="field">
    <label for="timezone">TZ</label>
    <select name="timezone" id="timezone">
        <option value="">none</option>
        <option value="-1200">-12 (IDLW)</option>
        <option value="-1100">-11 (NT)</option>
        <option value="-1000">-10 (HST)</option>
        <option value="-900">-9 (AKST)</option>
        <option value="-0800">-8 (PST/AKDT)</option>
        <option value="-0700">-7 (MST/PDT)</option>
        <option value="-0600">-6 (CST/MDT)</option>
        <option value="-0500">-5 (EST/CDT)</option>
        <option value="-0400">-4 (AST/EDT)</option>
        <option value="-0345">-3:45</option>
        <option value="-0330">-3:30</option>
        <option value="-0300">-3 (ADT)</option>
        <option value="-0200">-2 (AT)</option>
        <option value="-0100">-1 (WAT)</option>
        <option value="Z">+0 (GMT/UTC)</option>
        <option value="+0100">+1 (CET/BST/IST/WEST)</option>
        <option value="+0200">+2 (EET/CEST)</option>
        <option value="+0300">+3 (MSK/EEST)</option>
        <option value="+0330">+3:30 (Iran)</option>
        <option value="+0400">+4 (ZP4/MSD)</option>
        <option value="+0430">+4:30 (Afghanistan)</option>
        <option value="+0500">+5 (ZP5)</option>
        <option value="+0530">+5:30 (India)</option>
        <option value="+0600">+6 (ZP6)</option>
        <option value="+0630">+6:30 (Burma)</option>
        <option value="+0700">+7 (WAST)</option>
        <option value="+0800">+8 (WST)</option>
        <option value="+0900">+9 (JST)</option>
        <option value="+0930">+9:30 (Central Australia)</option>
        <option value="+1000">+10 (AEST)</option>
        <option value="+1100">+11 (AEST(summer))</option>
        <option value="+1200">+12 (NZST/IDLE)</option>
    </select>
    hour(s) from <abbr title="Greenwich Mean time">GMT</abbr>
 </div>

 <div class="field">
    <label for="description">description</label
    <textarea name="description" id="description" cols="33" rows="5" style="width: 200px;">#FORM.description#</textarea>
 </div>

 <div class="submit">
   <input type="submit" name="create" value="Create">
   <input type="reset" value="Reset">
 </div>
 </fieldset>
</form>
</div>

	<div class="output">
	<h2>Preview code</h2>
	<textarea id="samplecode" rows="18" cols="50"><cfif IsDefined("VARIABLES.hCalendar")>#HTMLEditFormat(VARIABLES.hCalendar)#</cfif></textarea>
	</div>
	
	<div id="previewblock">
		<h2>Preview output</h2>
		<div id="preview">
		<span><cfif IsDefined("VARIABLES.hCalendar")>#VARIABLES.hCalendar#</cfif></span>
		</div>
	</div>
</cfoutput>
	

</body>

</html>

</cfif>
