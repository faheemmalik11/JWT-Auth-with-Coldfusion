component{
    remote any function selectProducts(){
        sql = "SELECT * FROM products";
        products = QueryExecute(sql,[],{datasource= Application.dsn});
        return products;
    }

    remote any function selectCategoryProducts(category){
        sql = "SELECT * FROM products where CategoryId=?";
        products = QueryExecute(sql,[category],{datasource= Application.dsn});
        return products;
    }

    remote any function addToCart(id) returnformat="JSON" {
        sql = "SELECT InCart FROM products WHERE id=?";
        result = QueryExecute(sql,[id],{datasource= Application.dsn});
        if(result.InCart == 0){
            sql = "Update products SET InCart=1 WHERE id=?";
            products = QueryExecute(sql,[id],{datasource= Application.dsn});
            response = {
                "code" : 200,
                "message" : "Product added to cart successfully"
            };
            return serializeJSON(response);
        }
        response = {
            "code" : 400,
            "message" : "Product is already in Cart"
        };
        return serializeJSON(response);
    }
}