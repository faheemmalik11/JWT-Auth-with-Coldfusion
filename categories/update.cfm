<cfmodule template="/ecommerce-store/customTags/header.cfm">
<cfset id=#url.id#>
<cfquery datasource="#APPLICATION.dsn#" name="category">
    SELECT * FROM categories WHERE id=#id#
</cfquery>

<!-- component -->
<cfmodule template="/ecommerce-store/customTags/navbar.cfm">
<body class="bg-gray-50">
<div
  class="container max-w-md mx-auto my-64 xl:max-w-3xl h-2/4 flex bg-white rounded-lg shadow overflow-hidden"
>
  <div class="relative hidden xl:block xl:w-1/2 h-full">
    <cfoutput>
        <img
        class="absolute h-auto w-full object-cover"
        <cfif len(trim(category.ImagePath)) gt 0 >
            src="#category.ImagePath#"
            <cfelse>
                src="/ecommerce-store/assets/default.jpg"
        </cfif>
        alt="my zomato"
        />
    </cfoutput>
  </div>
  <div class="w-full xl:w-1/2 p-8">
    <form id="updateCategory" class="space-y-4 md:space-y-6"  >
        <cfoutput>
            <div>
                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                <input type="name" name="name" id="name" value="#category.CategoryName#" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required="">
            </div>
            <div>
                <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Description</label>
                <input type="description" name="description" id="description" value="#category.Description#" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" >
            </div>
            <div>
                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload Image</label>
                <input name="img" id="img" class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="file_input" type="file">
            </div>
            <button type="submit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Update</button>
            <p id="errorDisplay"></p>
        </cfoutput>
    </form>
  </div>
</div>

<script>
    
    $(document).ready(function(){
            $('#updateCategory').on('submit', function(e){
                e.preventDefault();
                var name = $("#name").val();
                var description = $("#description").val();
                var formData = new FormData($('#updateCategory')[0]);
                formData.append("id",<cfoutput>#id#</cfoutput>,)
                var token = JSON.parse($.cookie("auth_token"));
                console.log(token);
                var request = $.ajax({
                    url: "/ecommerce-store/categories/categories.cfc?method=update",
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
                                location.reload();
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

</body>
