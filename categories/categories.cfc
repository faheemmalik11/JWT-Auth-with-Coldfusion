component{
    remote function add() returnFormat="JSON"{

            sql = "SELECT * FROM categories WHERE CategoryName=?";
            selectCategory = QueryExecute(sql, [name],{datasource=APPLICATION.dsn});
            if(selectCategory.recordCount>0){
                response = {
                    code: 500,
                    message: "Name Already Exists"
                };
                return serializeJSON(response);
            }
            try{
                param name="img" default="";
                if(len(trim(img))){
                    destinationPath =expandPath("/ecommerce-store/assets/categories");
                    upload = FileUpload(destinationPath, "img", "","Overwrite",false,".jpg, .png, .jpeg");
                    imgPath = "/ecommerce-store/assets/categories/" & upload.SERVERFILE;
                    sql = "INSERT INTO categories (CategoryName, Description, ImagePath) VALUES (?, ?, ?)";
                    params = [name, trim(description), imgPath];
                    addCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
                }else{
                    sql = "INSERT INTO categories (CategoryName, Description) VALUES (?,?)";
                    params = [name, trim(description)];
                    addCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
                }
                    sql = "SELECT * FROM  categories WHERE CategoryName=?";
                    selectCategory = QueryExecute(sql, [name], {datasource=APPLICATION.dsn});
                    response = {
                        code: 200,
                        message: "Category Added successfully",
                        data: {
                            CategoryName: selectCategory.CategoryName,
                            Description: selectCategory.Description,
                            ImagePath: selectCategory.ImagePath
                        }
                    };
                    return serializeJSON(response);
            }catch(any e){
                response = {
                    code: 500,
                    message: e.message
                };
                return serializeJSON(response);
            }
    }

    remote function update() returnFormat="JSON"{

        try{
            param name="img" default="";
            if(len(trim(img))){
                destinationPath =expandPath("/ecommerce-store/assets/categories");
                upload = FileUpload(destinationPath, "img", "","Overwrite",false,".jpg, .jpeg, .png");
                imgPath = "/ecommerce-store/assets/categories/" & upload.SERVERFILE;
                sql = "UPDATE categories set CategoryName = ?, Description = ?, ImagePath = ? WHERE id=?";
                params = [name, trim(description), imgPath, id];
                updateCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }else{
                sql = "UPDATE categories set CategoryName = ?, Description = ? WHERE id=?";
                params = [name, trim(description),id];
                updateCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }
                sql = "SELECT * FROM  categories WHERE id=?";
                selectCategory = QueryExecute(sql, [id], {datasource=APPLICATION.dsn});
                response = {
                    code: 200,
                    message: "Category Updated successfully",
                    data: {
                        id: selectCategory.CategoryName,
                        CategoryName: selectCategory.CategoryName,
                        Description: selectCategory.Description,
                        ImagePath: selectCategory.ImagePath
                    }
                };
                return serializeJSON(response);
        }catch(any e){
            response = {
                code: 500,
                message: e.message
            };
            return serializeJSON(response);
        }
    }

    remote function delete(id) returnFormat="JSON" {

        try{
            sql = "DELETE FROM categories WHERE id=?";
            deleteQuery = QueryExecute(sql, [id], {datasource=APPLICATION.dsn});
            response = {
                code: 200,
                message: "Category deleted successfully"
            };
            return serializeJSON(response);
        }catch(any e){
            response = {
                code: 500,
                message: e.message
            };
            return serializeJSON(response);
        }
    }
}
