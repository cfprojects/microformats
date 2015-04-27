<cfsetting enablecfoutputonly="yes">

<!--- Initialize parameters --->
<cfparam name="FORM.URL2" default="http://ficlets.com/stories/12">
<cfparam name="FORM.bDump" default="0">

<!--- If the form was submitted --->
<cfif IsDefined("FORM.get") and IsValid('URL', FORM.URL2)>
	<cfset aAtoms = CreateObject('component', 'net.mollerus.microformats.hAtom').hAtomProxy('#FORM.URL2#')>
	
	<!--- If the information should be dumped --->
	<cfif Val(FORM.bDump)>
		<cfdump var="#aAtoms#">
	<cfelse><!--- Else send the information down as vCards --->
<cfoutput><cfloop index="index" from="1" to="#ArrayLen(aAtoms)#">#aAtoms[index]#

</cfloop></cfoutput>
	</cfif>
<cfelse><!--- Else show the form --->


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
<h2>Test <a href="http://microformats.org/wiki/hatom">hAtom</a></h2>


	<p><cfoutput>
	<div class="inputs">
	<form action="#CGI.SCRIPT_NAME#" method="post">
	<fieldset><legend>Get data from hAtoms</legend>
	<div class="field">
		<label for="URL2">URL:</label>
		<input type="text" name="URL2" value="#FORM.URL2#" size="50">
	</div>
	<div class="field">
		<label for="bDump">Dump&nbsp;data:</label>
		<input type="checkbox" name="bDump" value="1"<cfif Val(FORM.bDump)> checked</cfif>>
	</div>
	<div class="submit">
		<input type="submit" name="get" value="Get Atom data">
	</div>
	</fieldset>
	</form>
	</div></p>
	
	
	
</cfoutput>
	

</body>

</html>

</cfif>