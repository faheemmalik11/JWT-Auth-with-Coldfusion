<cfif isDefined("category")>
    <cfinvoke component="dashboard"  method="selectCategoryProducts" returnVariable="products" category="#category#">
    <cfelse>
        <cfinvoke component="dashboard"  method="selectProducts" returnVariable="products">
</cfif>

<!DOCTYPE html>

    <html lang="en">
    <cfmodule template="/ecommerce-store/customTags/header.cfm">
    <cfmodule template="/ecommerce-store/customTags/navbar.cfm">
    <body class="bg-gray-50" style="font-family: 'Source Sans Pro', sans-serif">

        <div class="text-center p-10">
            <h1 class="font-bold text-4xl mb-4">Responsive Product card grid</h1>
            <h1 class="text-3xl">Tailwind CSS</h1>
        </div>

        <!-- ✅ Grid Section - Starts Here 👇 -->
        <section id="Projects"
            class="w-fit mx-auto grid grid-cols-1 lg:grid-cols-3 md:grid-cols-2 justify-items-center justify-center gap-y-20 gap-x-14 mt-10 mb-5">

            <!--   ✅ Product card 1 - Starts Here 👇 -->
            <cfoutput>
                <cfloop query="products">
                    <div class="w-72 bg-white shadow-md rounded-xl duration-500 hover:scale-105 hover:shadow-xl">
                        <a href="/ecommerce-store/products/update.cfm?id=#id#">
                            <img 
                            
                            <cfif len(trim(ImagePath)) gt 0 >
                                src="#ImagePath#"
                                <cfelse>
                                    src="/ecommerce-store/assets/default.jpg"
                            </cfif>
                            alt="Product" class="h-80 w-72 object-cover rounded-t-xl" />
                        </a>
                            <div class="px-4 py-3 w-72">
                                <span class="text-gray-400 mr-3 uppercase text-xs">#Brand#</span>
                                <p class="text-lg font-bold text-black truncate block capitalize">#Name#</p>
                                <div class="flex items-center">
                                    <p class="text-lg font-semibold text-black cursor-auto my-3">$#Price#</p>
                                    <del>
                                        <p class="text-sm text-gray-600 cursor-auto ml-2">$#Price+20#</p>
                                    </del>
                                    <div class="ml-auto"><svg  data-id="#id#" xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            fill="currentColor" class="bi bi-bag-plus animate-pulse mailtoui cursor-pointer" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd"
                                                d="M8 7.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0v-1.5H6a.5.5 0 0 1 0-1h1.5V8a.5.5 0 0 1 .5-.5z" />
                                            <path
                                                d="M8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1zm3.5 3v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5zM2 5h12v9a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V5z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>

                    </div>
                </cfloop>
            </cfoutput>
            <!--   🛑 Product card  - Ends Here  -->

            
        </section>

        <!-- 🛑 Grid Section - Ends Here -->

<script>
    $("svg").click(function(){
        var token = JSON.parse($.cookie("auth_token"));
        var id = $(this).data("id");
        var request = $.ajax({
                                    url: "/ecommerce-store/dashboard/dashboard.cfc?method=addToCart",
                                    headers: {
                                        "Authorization": token
                                    },
                                    type: "POST",
                                    data: {
                                        id: id
                                    },
                                    });

                                    request.done(function(res) {
                                        var parsed = $.parseJSON(res);
                                        if(parsed.code == 200){
                                            Swal.fire({
                                                title: "Added!",
                                                text: parsed.message,
                                                icon: "success"
                                            });
                                            
                                        }else{
                                            Swal.fire({
                                                title: "Error!",
                                                text: parsed.message,
                                                icon: "error"
                                            });
                                        }
                                    });

                                    request.fail(function(jqXHR, textStatus) {
                                    alert( "Request failed: " + textStatus );
                                });
    })
</script>



       
    </body>
    </html>