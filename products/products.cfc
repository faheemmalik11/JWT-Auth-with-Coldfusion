component{
    remote any function selectCategories(){
        sql = "SELECT * FROM categories";
        categories = QueryExecute(sql,[],{datasource= Application.dsn});
        return categories;
    }
    remote any function selectProduct(id){
        sql = "SELECT * FROM products WHERE id=?";
        product = QueryExecute(sql,[id],{datasource= Application.dsn});
        return product;
    }


    remote function add() returnFormat="JSON"{

        try{
            param name="img" default="";
            if(len(trim(img))){
                destinationPath =expandPath("/ecommerce-store/assets/products");
                upload = FileUpload(destinationPath, "img", "","Overwrite",false,".jpg, .png");
                imgPath = "/ecommerce-store/assets/products/" & upload.SERVERFILE;
                sql = "INSERT INTO products (Name, Description, Price, Quantity, Brand, CategoryId, ImagePath) VALUES (?,?,?,?,?,?,?)";
                params = [name, trim(description), price, quantity, brand, category, imgPath];
                addCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }else{
                sql = "INSERT INTO products (Name, Description, Price, Quantity, Brand, CategoryId) VALUES (?,?,?,?,?,?)";
                params = [name, trim(description), price, quantity, brand, category];
                addCategory = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }
                response = {
                    code: 200,
                    message: "Product Added successfully",
                    data: {
                        Name: name,
                        Description: trim(description),
                        Price: price,
                        Quantity: quantity,
                        Brand:brand,
                        CategoryId:category
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
                destinationPath =expandPath("/ecommerce-store/assets/products");
                upload = FileUpload(destinationPath, "img", "","Overwrite",false,".jpg, .png");
                imgPath = "/ecommerce-store/assets/products/" & upload.SERVERFILE;
                sql = "UPDATE products set Name = ?, Description = ?, Price = ?, Brand = ?, Quantity = ?, CategoryId = ?, ImagePath = ? WHERE id=?";
                params = [name, trim(description), price, brand, quantity, category, imgPath, id];
                updateProduct = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }else{
                sql = "UPDATE products set Name = ?, Description = ?, Price = ?, Brand = ?, Quantity = ?, CategoryId = ? WHERE id=?";
                params = [name, trim(description), price, brand, quantity, category, id];
                updateProduct = QueryExecute(sql, params, {datasource=APPLICATION.dsn});
            }
                sql = "SELECT * FROM products WHERE id=?";
                selectProduct = QueryExecute(sql, [id], {datasource=APPLICATION.dsn});
                response = {
                    code: 200,
                    message: "Product Updated successfully",
                    data: {
                        Name: selectProduct.Name,
                        Description: selectProduct.Description,
                        Price: selectProduct.Price,
                        Quantity: selectProduct.Quantity,
                        Brand:selectProduct.Brand,
                        CategoryId:selectProduct.CategoryID
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
            sql = "DELETE FROM products WHERE id=?";
            deleteQuery = QueryExecute(sql, [id], {datasource=APPLICATION.dsn});
            response = {
                code: 200,
                message: "Product deleted successfully"
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