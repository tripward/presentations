
<cfif !structIsEmpty(form) OR !structIsEmpty(url)>
	
	<!---every form has a hidden form field csrftoken with a value of sessionid, check on all submissions--->
	<cfif !structIsEmpty(form) AND structKeyExists(form,"csrftoken")>
		<cfset application.SecurityUtils.csrfCheck(session.sessionID,form.csrfToken) />
	</cfif>
	
	<!---every form has a hidden form field csrftoken with a value of sessionid, check on all submissions--->
	<cfif !structIsEmpty(url) AND structKeyExists(url,"csrfToken")>
		<cfset application.SecurityUtils.csrfCheck(session.sessionID,url.csrfToken) />

	</cfif>
	
</cfif>
