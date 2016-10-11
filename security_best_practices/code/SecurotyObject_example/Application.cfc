<cfcomponent>
	<!---enables the ability to run muliple copies of the app --->
	<cfset This.name = "myApplication_#hash(GetCurrentTemplatePath())#">
	<cfset This.SessionManagement=True>
	<!---handled by session cooikies, client management is in secure--->
	<cfset This.ClientManagement=FALSE>
	<cfset This.ApplicationTimeout="#CreateTimeSpan(1,0,0,0)#"/>
	<cfset This.SessionTimeout="#CreateTimeSpan(0,1,0,0)#"/>
	<cfset This.SetClientCookies = false />
	<cfset This.SetDomainCookies = false />
	<cfset This.ScriptProtect = "ALL" />
	
	<cffunction name="onApplicationStart">
		
		<!---put variables scope etc into application scope as well--->
		<cfset application = THIS /> 
		
		<!---create security object--->
		<cfset application.SecurityUtils = createObject("component","org.main.services.SecurityUtils").init() />
		
	</cffunction>
	
	<cffunction name="onSessionStart">
		
		<!---if a new jsessionid is given, but there is already a session cookie, don't assign new one--->
		<cfif structKeyExists(SESSION,'jsessionID') AND !structKeyExists(COOKIE,'jsessionID')>	
			 
			 <!---create session based cookie--->
			 <CFIF structKeyExists(SESSION,'sessionID') and !structKeyExists(cookie,'jsessionID')>
				<CFCOOKIE NAME="jsessionID" VALUE="#SESSION.sessionID#" httponly="yes" secure="#cgi.server_port_secure#">
			</CFIF>
		
		</cfif>
		
		<!---create a session token that can be used to tie form submits to submitter--->
		<cfif !structKeyExists(session,"sessionID")>
			<cfset SESSION.CSRFToken = SESSION.sessionID />
		</cfif>
		
		<!--- for bots this will return true and use the low session timeout. goto app.securityutils and add bots --->
		<cfif application.SecurityUtils.isBot(cgi)>
		 	<cfset this.sessiontimeout = CreateTimeSpan(0,0,0,20) />
		</cfif>
				
	</cffunction>

	<cffunction name="onRequestStart">
		
		<!--- query string too long, buffer overflow --->
		<cfif len(cgi.QUERY_STRING) GT 2000>
			That wasn't very nice
			<cfabort />
		</cfif>
	
		<!--- manual and custom check for xss strings as threats evolve --->
		<cfinclude template="/xss.cfm" />
		
		<!---ensure if a form is submitted, the submitter is the same as filling it out--->
		<cfinclude template="/csrfCheck.cfm" />
	
		<!--- Optionally reload the application / session. --->
		<cfif StructKeyExists(URL, "reloadApp")>
			
			<cflock timeout="5" scope="Application" type="exclusive">
				<cfset ApplicationStop() />
				<cfset onApplicationStart() />
			</cflock>
			
			<cflock timeout="5" scope="Application" type="exclusive">
				<cfset onSessionStart() />
			</cflock>
			
			<cflocation url="#cgi.scrIPT_NAME#" addtoken="false" />
			<cfabort />
		</cfif>
		
		
			
	</cffunction>
	
	<cffunction name="OnSessionEnd">
		<cfargument name = "SessionScope" required=true/>
		
		<cfset structClear(arguments.SessionScope)> <!--- session --->
	</cffunction>
	
	<cffunction name="onError">
	    <cfargument name="Exception" required=true/>
	    <cfargument type="String" name = "EventName" required=false/>

		<cfinclude template="/includes/requesterror.cfm">
		
	</cffunction>

	<cffunction name="onMissingTemplate">
		<cfargument name="targetPage" type="string" required=true/>

		<!--- Use a try block to catch errors. --->
		<cftry>
			<!--- Log all errors. --->
			<cflog type="error" text="Missing template: #Arguments.targetPage#">
			<!--- Display an error message. --->
			<cfoutput>
				<h3>Page not found.</h3>
				<p>You requested a non-existent page.<br />
				Please check the URL.</p>
				</cfoutput>
				<cfreturn true />
				<!--- If an error occurs, return false and the default error handler will run. --->
			<cfcatch>
				<cfreturn false />
			</cfcatch>
		</cftry>
		
	</cffunction>
	
</cfcomponent>