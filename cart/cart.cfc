component{
    remote any function  cartProducts(){
        sql = "SELECT * FROM products WHERE InCart=1";
        products = QueryExecute(sql,[],{datasource= Application.dsn});
        return products;
    }

    remote any function  removeFromCart(id) returnFormat="JSON"{
        sql = "SELECT InCart FROM products WHERE id=?";
        result = QueryExecute(sql,[id],{datasource= Application.dsn});
        if(result.InCart == 1){
            sql = "Update products SET InCart=0 WHERE id=?";
            products = QueryExecute(sql,[id],{datasource= Application.dsn});
            response = {
                "code" : 200,
                "message" : "Product removed to cart successfully"
            };
            return serializeJSON(response);
        }
        response = {
            "code" : 400,
            "message" : "Product is not in Cart"
        };
        return serializeJSON(response);
    }
}
