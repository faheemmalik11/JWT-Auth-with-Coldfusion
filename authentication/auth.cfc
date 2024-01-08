<cfcomponent displayname="auth" hint="ColdFusion Component for SignUp">
  
  <cffunction name="signup" access="remote"
    returnFormat="JSON">
    
    <cfargument  name="name" type="string">
    <cfargument  name="email" type="string">
    <cfargument  name="password" type="string">
    <cfset hashedPassword = hash(password, "SHA-256", "UTF-8")>

    <cfquery datasource="#Application.dsn#" name="checkUser">
      SELECT * FROM users where email='#email#'
    </cfquery>
    <cfif checkUser.recordCount neq 0>
      <cfset response = structNew() >
      <cfset response["code"] = 500>
      <cfset response["message"] = 'Sorry, the user is already in database.' >
      <cfreturn response>
    </cfif>





    <cftry>
      <cfquery datasource="#Application.dsn#" name="insetUser">
        INSERT INTO users (name,email, password) VALUES ('#name#','#email#','#hashedPassword#')
      </cfquery>
      <cfquery datasource="#Application.dsn#" name="selectUser">
        SELECT * FROM users where email='#email#'
      </cfquery>
        <cfset response = structNew() >
        <cfset response["code"] = 200>
        <cfset response["data"]["id"] = #selectUser.id#>
        <cfset response["data"]["name"] = #selectUser.name#>
        <cfset response["data"]["email"] = #selectUser.email#>
        <cfset response["data"]["pfp"] = #selectUser.pfp#>
        <cfset response["data"]["description"] = #selectUser.description#>

        <!---         TOKEN CREATION --->
        <cfset data = structNew()>
        <cfset data["id"] = #selectUser.id#>
        <cfset data["name"] = #selectUser.name#>
        <cfset data["email"] = #selectUser.email#>
        <cfset data["pfp"] = #selectUser.pfp#>
        <cfset data["description"] = #selectUser.description#>

        <cfinvoke component="/ecommerce-store/jws/jwt"  method="createJwt" returnvariable="token"  payload="#data#">

        <cfset response["token"] = #token#>

      <cfreturn response>
    <cfcatch type="database">
      <cfset response = structNew() >
      <cfset response["code"] = 500>
      <cfset response["message"] = 'Sorry, the database threw an error: #cfcatch.queryError#.  Try again later.' >
      <cfreturn response>
    </cfcatch>
    </cftry>


  </cffunction>

  <cffunction name="login" access="remote"
    returnFormat="JSON">
    <cfargument  name="email" type="string">
    <cfargument  name="password" type="string">
    <cfset hashedPassword = hash(password, "SHA-256", "UTF-8")>
    


    <cftry>
      <cfquery datasource="#Application.dsn#" name="selectUser">
            SELECT * FROM users where email='#email#'
      </cfquery>
      <cfif selectUser.password eq hashedPassword>
        <cfset response = structNew() >
        <cfset response["code"] = 200>
        <cfset response["data"]["id"] = #selectUser.id#>
        <cfset response["data"]["name"] = #selectUser.name#>
        <cfset response["data"]["email"] = #selectUser.email#>
        <cfset response["data"]["pfp"] = #selectUser.pfp#>
        <cfset response["data"]["description"] = #selectUser.description#>

<!---         TOKEN CREATION --->
        <cfset data = structNew()>
        <cfset data["id"] = #selectUser.id#>
        <cfset data["name"] = #selectUser.name#>
        <cfset data["email"] = #selectUser.email#>
        <cfset data["pfp"] = #selectUser.pfp#>
        <cfset data["description"] = #selectUser.description#>

        <cfinvoke component="/ecommerce-store/jws/jwt"  method="createJwt" returnvariable="token"  payload="#data#">
        <cfset response["token"] = #token#>
        <cfelse>
          <cfset response = structNew() >
          <cfset response["code"] = 401>
          <cfset response["message"] = 'Sorry, you are an authenticated user' >

      </cfif>

    
       <cfreturn response>
    <cfcatch type="database">
      <cfset response = structNew() >
      <cfset response["code"] = 500>
      <cfset response["message"] = 'Sorry, the database threw an error: #cfcatch.queryError#.  Try again later.' >

      <cfreturn response>
    </cfcatch>
    </cftry>


  </cffunction>
 </cfcomponent>
