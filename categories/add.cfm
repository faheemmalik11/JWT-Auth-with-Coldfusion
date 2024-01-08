<cfmodule template="/ecommerce-store/customTags/header.cfm">
<cfmodule template="/ecommerce-store/customTags/navbar.cfm">
<body class="bg-gray-50 dark:bg-gray-900">
    <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
        <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
            <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
                <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
                    Add Category
                </h1>
                <form class="space-y-4 md:space-y-6" id="addCategory" >
                    <div>
                        <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                        <input type="name" name="name" id="name" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required="">
                    </div>
                    <div>
                        <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Description</label>
                        <input type="description" name="description" id="description" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" >
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload Image</label>
                        <input name="img" id="img" class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="file_input" type="file">
                    </div>
                    <button type="submit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Add</button>
                    <p id="errorDisplay"></p>
                    
                </form>

            </div>
        </div>
    </div>
</body>

<script>

$(document).ready(function(){
        $('#addCategory').on('submit', function(e){
            e.preventDefault();
            var name = $("#name").val();
            var description = $("#description").val();
            var formData = new FormData($('#addCategory')[0]);
            var token = JSON.parse($.cookie("auth_token"));
            var request = $.ajax({
                url: "/ecommerce-store/categories/categories.cfc?method=add",
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
                                window.location.href="/ecommerce-store/categories/index.cfm";
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
