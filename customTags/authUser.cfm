<cfset authUserData = {}>
<cfif structKeyExists(COOKIE, "auth_user")>

    <!--- Deserialize the JSON string into a ColdFusion structure --->
    <cfset authUserData = deserializeJSON(COOKIE.auth_user)>
    <cfset caller[ attributes.returnVar ] = #authUserData# />
    
<cfelse>
    <cfoutput>auth_user cookie not found</cfoutput>
    <cfabort>
</cfif>