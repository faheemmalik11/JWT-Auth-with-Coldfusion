component {
    remote function update() returnformat="JSON" {
        try {
            authUser = deserializeJSON(COOKIE.auth_user);
            param name="pfp" default="";

            if(len(trim(pfp))){
                destinationPath =expandPath("/ecommerce-store/assets/pfps");
                upload = FileUpload(destinationPath, "pfp", "","Overwrite",false,".jpg, .png");
                pfpPath = "/ecommerce-store/assets/pfps/" & upload.SERVERFILE;
                sql = "UPDATE users SET name=?, email=?, pfp=?, description=? WHERE id=?";
                params = [name, email, pfpPath, trim(description), authUser.id];
                updateProfile = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }else{
                sql = "UPDATE users SET name=?, email=?, description=? WHERE id=?";
                params = [name, email, trim(description), authUser.id];
                updateProfile = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }
                sql = "SELECT * FROM  users WHERE id=?";
                selectProfile = QueryExecute(sql, [authUser.id], {datasource=APPLICATION.dsn});

                response = {
                    code: 200,
                    message: "profile Updated Successfully",
                    data: {
                        name: selectProfile.name,
                        email: selectProfile.email,
                        pfp: selectProfile.pfp,
                        description: selectProfile.description
                    }
                };
                return serializeJSON(response);

        } catch (Database e) {
            return "Error: " & e.message;
        }
    }
}
