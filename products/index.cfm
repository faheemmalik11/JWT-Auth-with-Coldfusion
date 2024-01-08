
<cfmodule template="/ecommerce-store/customTags/header.cfm">
    <cfquery datasource="#APPLICATION.dsn#" name="products">
        SELECT * FROM products
    </cfquery>
    <cfset attributes.data = products>
    <cfset attributes.name = "products">
    <body class="bg-gray-50 text-gray-900 tracking-wider leading-normal">
        <cfmodule template="/ecommerce-store/customTags/navbar.cfm">
            
            <!--Container-->
            <div class="container w-full md:w-4/5 xl:w-3/5  mx-auto px-2">
        
                <!--Title-->
                <h1 class="flex items-center font-sans font-bold break-normal text-indigo-500 px-2 py-8 text-xl md:text-2xl">
                    Products
                </h1>
        
                <button id='addProduct'  type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Add Product</button>
                <!--Card-->
                <div id='recipients' class="p-8 mt-6 lg:mt-0 rounded shadow bg-white">
    
                    <cfmodule template="/ecommerce-store/customTags/table.cfm" data="#attributes.data#" dir="#attributes.name#">
                    
                </div>
                <!--/Card-->
            
            
            </div>
            <!--/container-->
    
            <script>
                $("#addProduct").click(function(){
                    window.location.href ="/ecommerce-store/products/add.cfm";
                });
            </script>
    </body>