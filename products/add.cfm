<cfinvoke component="products"  method="selectCategories" returnVariable="categories">
<cfmodule template="/ecommerce-store/customTags/header.cfm">
    <cfmodule template="/ecommerce-store/customTags/navbar.cfm">
        <body class="bg-gray-50 dark:bg-gray-900 ">
            <form id="addProduct">
            <div class="flex px-4 py-8  md:h-screen lg:py-0  justify-center items-center  ">
                <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
                    <div class="p-6 space-y-4 md:space-y-6 sm:p-8 ">
                        <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
                            Add Product
                        </h1>
                            <div class="flex flex-wrap -mx-3 mb-6">
                                <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="name">
                                        Name
                                    </label>
                                    <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="name" type="text" name="name" >
                                    <p class="text-red-500 text-xs italic">Please fill out this field.</p>
                                </div>
                                <div class="w-full md:w-1/2 px-3">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="brand">
                                    Brand
                                    </label>
                                    <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="brand" type="text" name="brand" >
                                </div>
                                </div>
                                <div class="flex flex-wrap -mx-3 mb-6">
                                <div class="w-full px-3">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="description">
                                        Description
                                    </label>
                                    <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="description" type="text" name="description" >
                                </div>
                                </div>
                                <div class="flex flex-wrap -mx-3 mb-2">
                                <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="quantity">
                                        Quantity
                                    </label>
                                    <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="quantity" type="number" min="0" name="quantity" >
                                </div>
                                <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="category">
                                        Category
                                    </label>
                                    <div class="relative">
                                    <select class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="categories">
                                        <cfoutput>
                                            <cfloop query="categories">
                                                <option value="#id#">#CategoryName#</option>
                                            </cfloop>
                                        </cfoutput>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                    </div>
                                    </div>
                                </div>
                                <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="price">
                                    Price
                                    </label>
                                    <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="price" type="number" min="0" name="price">
                                </div>
                                <button type="submit" class="w-full my-5 text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Add</button>
                                <p id="errorDisplay"></p>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="w-64 mx-4">

                    <cfif NOT isNull(user.pfp)>
                        <img src="#user.pfp#" class="rounded-none lg:rounded-lg shadow-2xl hidden lg:block">
                    <cfelse>
                        <img src="/ecommerce-store/assets/default.jpg" class="rounded-none lg:rounded-lg shadow-2xl hidden lg:block">
                    </cfif>
                
                    <label class="block mt-2">
                        <span class="sr-only">Choose product photo</span>
                        <input id="img" name="img" type="file" class="block w-full text-sm text-gray-500
                            file:me-4 file:py-2 file:px-4
                            file:rounded-lg file:border-0
                            file:text-sm file:font-semibold
                            file:bg-transparent file:text-white
                            hover:file:bg-green-700
                            file:disabled:opacity-50 file:disabled:pointer-events-none
                            dark:file:bg-blue-500
                            dark:hover:file:bg-blue-400
                        ">
                    </label>
                </div>        
            </div>
        </form>
        </body>
    
    <script>
    
    $(document).ready(function(){
            $('#addProduct').on('submit', function(e){
                e.preventDefault();
                var selectedValue =  $("#categories").val()
                var formData = new FormData($('#addProduct')[0]);
                formData.append("category",selectedValue);
                var token = JSON.parse($.cookie("auth_token"));
                var request = $.ajax({
                    url: "/ecommerce-store/products/products.cfc?method=add",
                    headers: {
                        "Authorization": token
                    },
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false
                    });
    
                    request.done(function(res) {
                        var parsed = JSON.parse(res);
                            if(parsed.CODE == 200){
                                Swal.fire({
                                    position: "top-end",
                                    icon: "success",
                                    title: parsed.MESSAGE,
                                    showConfirmButton: false,
                                    timer: 1500
                                });
                                setTimeout(function() {
                                    window.location.href="/ecommerce-store/products/index.cfm";
                                }, 3000);
                            }else{
                                Swal.fire({
                                            title: "Error!",
                                            text: parsed.MESSAGE,
                                            icon: "error"
                                        });
                            }
                    });
    
                    request.fail(function(jqXHR, textStatus) {
                    alert( "Request failed: " + textStatus );
                });
            });
        });
    </script>
    