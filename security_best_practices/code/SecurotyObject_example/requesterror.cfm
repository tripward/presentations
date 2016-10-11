


<!---
The file is run from two cases - 

web.config if ststus 500 is thrown
Arguments will not exist, if this is the case, cf error handler isn't needed, so we just display basic message
check your dev tools notwork tab

applicationProxy.onError
Arguments will  exist, and exception will be the name

 Here we determine where this script is being called from to get the Exception object.
If from Mura, it is in onSiteError() in \wwwroot\ovcttac\includes\eventHandler.cfc. The arguments.$ is the alias for the mura.cfobject which gives access to Mura functions.
If from a onError() in an Application.cfc included in a folder to stop reaching the Mura Application.cfc in /wwwroot, it is defined in arguments.Exception.
 --->

<cfinclude template="/ovcttac_env/envSettings_Request.cfm" >

<!---<cfset variables.pageTitle = "Website Error" />--->

<!---<cfsavecontent variable="variables.single_col">--->
	<p align="center"><strong>We're sorry, an issue has been encountered on this page.</strong></p>
	<p align="center">The administrator has been e-mailed.</p>
	<p align="center">Please try later while we try to quickly fix the issue.</p>
	<p align="center">Thank you.</p>
	
	<!---if this page is being thrown from cf onError--->
	<cfif isDefined("arguments")>
	
		<cfif request.isShowFullDebugging>
			<cfdump var="#arguments.exception#" label="exception" abort="true" top="3">
		</cfif>
		
		<cfset request.logEntry = "" />
		
		<cftry>
			<!---build log message based on error type--->
			<cfswitch expression="#arguments.exception.type#" > 
				<cfcase value="template" >
					<cfset request.logEntry = "Message: #arguments.exception.messasge# on Template #listLast(arguments.exception.tagContext[1].template, '\')# on line  #arguments.exception.tagContext[1].line#" />
				</cfcase>
				<cfcase value="database" >
					<cfset request.logEntry = "Message: #arguments.exception.rootCause.messasge# - #arguments.exception.rootCause.detail# on Template #listLast(arguments.exception.tagContext[1].template, '\')# on line  #arguments.exception.tagContext[1].line#" />
				</cfcase>
				<cfdefaultcase>
					<cfset request.logEntry = "Message: #arguments.exception.messasge# on Template #listLast(arguments.exception.tagContext[1].template, '\')# on line  #arguments.exception.tagContext[1].line#" />
				</cfdefaultcase>
			</cfswitch>
		
			<!--- Log all errors. --->        
	        <cflog file="#This.Name#" type="error" text="#request.logEntry#">
			
	        <!--- If an error occurs with logging display a different error message. --->
	        <cfcatch type="any" >
			  
			  <cfoutput>
	              <h2>There has been an error while trying to write to the error log in request on error.</h2>
	              <p>Please contact the OVC TTAC site administrator if you continue to see this message.</p>
	          </cfoutput>
	          
	          <cfabort />
	          
	        </cfcatch>
	  </cftry>
	  
	</cfif>