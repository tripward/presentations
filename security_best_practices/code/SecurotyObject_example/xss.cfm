
<!---Check theese as a whole so you may be able to skip the next checks--->
<cfset application.SecurityUtils.xssCheck(cgi.QUERY_STRING) />
<cfset application.SecurityUtils.xssCheck(cgi.http_referer) />

<!---Check form fields for xss--->
<cfif !structIsEmpty(form)>
	<cfloop collection="#form#" item="request.theFormField">
		<cfset application.SecurityUtils.xssCheck(form[request.theFormField]) />
	</cfloop>
</cfif>

<!---Check url fields for xss--->
<cfif !structIsEmpty(url)>
	<cfloop collection="#url#" item="request.theUrlField">
		<cfset application.SecurityUtils.xssCheck(request.theUrlField) />
	</cfloop>
</cfif>

