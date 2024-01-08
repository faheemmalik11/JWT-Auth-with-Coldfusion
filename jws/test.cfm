<cfset data = structNew()>
<cfset data["name"] = "zubair">
<cfinvoke component="jwt"  method="createJwt" returnvariable="jwt"  payload="#data#">

<cfinvoke component="jwt"  method="verifyJwt" returnvariable="payload"  token=#jwt['token']# secretKey=#jwt['secretKey']#>
        <cfdump  var="#payload#">