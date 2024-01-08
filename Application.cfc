component{
    import "jws.jwt";
    this.application = 'ecommerce-store';
    this.sessionManagement='yes';

    function onApplicationStart(){
        application.dsn = "ecommerce_store";
        localSecretKey = generateSecretKey(("AES"), 128);
        application.secretKey = localSecretKey;
    }

    function onRequestStart(targetPage){
        var fileExtension = ListLast(targetPage, ".");
  
        if( fileExtension=="cfc" && getFileFromPath(targetPage) != 'auth.cfc' && getFileFromPath(targetPage) != 'jwt.cfc' ){
           var jwtComponent = new jwt();

           httpRequestData = getHttpRequestData();
           requestHeaders = httpRequestData.headers;
           var token = requestHeaders.Authorization;
            var payload = jwtComponent.verifyJwt(token);
        }

        
    }
}