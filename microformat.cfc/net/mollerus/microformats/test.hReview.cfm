<cfsetting enablecfoutputonly="yes">

<!--- Initialize parameters --->
<cfparam name="FORM.URL2" default="http://corkd.com/wine/view/21670-Beringer_California_Collection_White_Merlot_2005_">
<cfparam name="FORM.format" default="XHTML">
<cfparam name="FORM.bDump" default="0">
<cfparam name="FORM.item" default="">
<cfparam name="FORM.summary" default="">
<cfparam name="FORM.type" default="">
<cfparam name="FORM.reviewer" default="">
<cfparam name="FORM.startMonth" default="#Month(Now())#">
<cfparam name="FORM.startDay" default="#Day(Now())#">
<cfparam name="FORM.startYear" default="">
<cfparam name="FORM.URL" default="http://">
<cfparam name="FORM.rating" default="1">
<cfparam name="FORM.ratingBest" default="100">
<cfparam name="FORM.description" default="">
<cfparam name="FORM.license" default="#HTMLEditFormat('<a href="http://creativecommons.org/licenses/by-sa/2.5/" rel="license">Licensed under a creative commons attribution share alike 2.5 license</a>')#">

<!--- If the form was submitted --->
<cfif IsDefined("FORM.get") and IsValid('URL', FORM.URL2)>
	<cfset aReviews = CreateObject('component', 'net.mollerus.microformats.hReview').hReviewProxy(FORM.URL2, FORM.format)>
	
	<!--- If the information should be dumped --->
	<cfif Val(FORM.bDump)>
		<cfdump var="#aReviews#">
	<cfelse><!--- Else send the information down as vCards --->
<cfoutput><cfloop index="index" from="1" to="#ArrayLen(aReviews)#">#aReviews[index]#

</cfloop></cfoutput>
	</cfif>
<cfelse><!--- Else show the form --->

	<cfif IsDefined("FORM.create")><!--- Else if an hReview is requested --->
		<cfset FORM.date = CreateDate(FORM.startyear, FORM.startmonth, FORM.startday)>
		<cfset VARIABLES.hReview = CreateObject('component', 'net.mollerus.microformats.hReview').create(argumentCollection = FORM)>
	</cfif>


<cfsetting enablecfoutputonly="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

<head>
<title>hReview Test for net.mollerus.microformats.hReview</title>
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

<body><!--- Else show the form --->
<h2>Test <a href="http://microformats.org/wiki/hreview">hReview</a></h2>


	<p><cfoutput>
	<div class="inputs">
	<form action="#CGI.SCRIPT_NAME#" method="post">
	<fieldset><legend>Get data from hReviews</legend>
	<div class="field">
		<label for="URL2">URL:</label>
		<input type="text" name="URL2" value="#FORM.URL2#" size="50"> as <select name="format"><option value="XHTML">XHTML</option><option value="XML">XML</option></select>
	</div>
	<div class="field">
		<label for="bDump">Dump&nbsp;data:</label>
		<input type="checkbox" name="bDump" value="1"<cfif Val(FORM.bDump)> checked</cfif>>
	</div>
	<div class="submit">
		<input type="submit" name="get" value="Get review data">
	</div>
	</fieldset>
	</form>
	</div></p>
	
	
	<br clear="both" />
	
<div class="inputs">
<form action="#CGI.SCRIPT_NAME#" method="post">
 <fieldset><legend>Create hReview</legend>

 <div class="field">
  <label for="item">Item&nbsp;reviewed</label>
  <input type="text" id="item" name="item" value="#FORM.item#" />
 </div>
 <div class="field">
  <label for="summary">Summary</label>
  <input type="text" id="summary" name="summary" value="#FORM.summary#" />
 </div>
 <div class="field">
  <label for="type">Type</label>
    <select name="type" id="type" ><cfloop index="index" list="product,business,event,person,place,website,url">
        <option value="#index#"<cfif FORM.type eq index> selected</cfif>>#index#</option></cfloop>
    </select>
 </div>

 <div class="field">
    <label for="startMonth">Review&nbsp;date</label>
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
  <label for="reviewer">Reviewer&nbsp;name</label>
  <input type="text" id="reviewer" name="reviewer" value="#FORM.reviewer#" /> 
 </div>
 <div class="field">
  <label for="url">url</label>
  <input type="text" id="url" name="URL" value="#FORM.URL#" /> 
 </div>
 <div class="field">
  <label for="rating">Rating</label>
  <input type="text" id="rating" name="rating" value="#FORM.rating#" style="width: 50px;" /> out of <input type="text" id="ratingBest" name="ratingBest" value="#FORM.ratingBest#" style="width: 50px;" />
 </div>
 <div class="field">
  <label for="description">Description</label>
  <textarea name="description" id="description" cols="33" rows="5" style="width: 300px;">#FORM.description#</textarea> 
 </div>
 <div class="field">
  <label for="license">License</label>
  <textarea name="license" id="license" cols="33" rows="5" style="width: 300px;">#FORM.license#</textarea> 
 </div>

 <div class="submit">
   <input type="submit" name="create" value="Create">
   <input type="reset" value="Reset">
 </div>
 </fieldset>
</form>
</div>

<div class="output">
<h2>Preview Code</h2>
<textarea id="samplecode" rows="18" cols="50"><cfif IsDefined("VARIABLES.hReview")>#HTMLEditFormat(VARIABLES.hReview)#</cfif></textarea>
</div>

<div id="previewblock">
	<h2>Preview output</h2>
	<div id="preview">
	<span><cfif IsDefined("VARIABLES.hReview")>#VARIABLES.hReview#</cfif></span>
	</div>
</div>
</cfoutput>
	

</body>

</html>

</cfif>
