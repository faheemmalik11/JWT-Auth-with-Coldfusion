component{
    // Create an Hmac-based client.
    import lib ;


    // Or, just use the .encode() and .decode() methods directly:
     this.jwt = new lib.JsonWebTokens();

    // Encode a payload:
    function createJwt(payload){
        var token = this.jwt.encode( payload, "HS256", application.secretKey);
        return token;
    }

    // Decode a payload:
    function verifyJwt(token){
        var payload = this.jwt.decode(token, "HS256", application.secretKey );
        return payload;
    }


}
