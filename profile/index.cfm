<cfmodule template="/ecommerce-store/customTags/header.cfm">
<cfmodule template="/ecommerce-store/customTags/authUser.cfm" returnVar="authUser">
<cfquery datasource="#APPLICATION.dsn#" name="user">
    SELECT * FROM users WHERE id='#authUser.id#'
</cfquery>
<cfoutput>
<form  id="updateProfile" enctype="multipart/form-data" method="post">
    <body class="font-sans antialiased text-gray-900 leading-normal tracking-wider bg-cover"
    style="background-image:url('https://source.unsplash.com/1L71sPT5XKc');">



        <div class="max-w-4xl flex items-center h-auto lg:h-screen flex-wrap mx-auto my-32 lg:my-0">
                <!--Main Col-->
                <div id="profile"
                    class="w-full lg:w-3/5 rounded-lg lg:rounded-l-lg lg:rounded-r-none shadow-2xl bg-white opacity-75 mx-6 lg:mx-0">

                    
                    <div class="p-4 md:p-12 text-center lg:text-left">
                        <!-- Image for mobile view-->
                        <cfif NOT isNull(user.pfp)>
                            <div class="block lg:hidden rounded-full shadow-xl mx-auto -mt-16 h-48 w-48 bg-cover bg-center"
                            style="background-image: url(#user.pfp#)"></div>
                            <cfelse>
                                <div class="block lg:hidden rounded-full shadow-xl mx-auto -mt-16 h-48 w-48 bg-cover bg-center"
                                style="background-image: url('/ecommerce-store/assets/default_avatar.jpg')"></div>
                        </cfif>
                        

                        <h1 id="name" class="text-3xl font-bold pt-8 lg:pt-0" contentEditable="true" name="name">#user.name#</h1>
                        <div class="mx-auto lg:mx-0 w-4/5 pt-3 border-b-2 border-green-500 opacity-25"></div>
                        <p class="pt-4 text-base font-bold flex items-center justify-center lg:justify-start">
                            <svg class="h-4 fill-current text-green-700 pr-4" xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20">
                                <path
                                    d="M9 12H1v6a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-6h-8v2H9v-2zm0-1H0V5c0-1.1.9-2 2-2h4V2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v1h4a2 2 0 0 1 2 2v6h-9V9H9v2zm3-8V2H8v1h4z" />
                            </svg> <span id="email" contentEditable="true" name="email" >#user.email#</span>
                        </p>
                        
                            <p id="description" name="description" class="pt-8 text-sm" contentEditable="true">
                                <cfif NOT isNull(user.description)> 
                                    #user.description#
                                    <cfelse>
                                    Totally optional short description about yourself, what you do and so on.
                                </cfif>
                            </p>
                    </div>

                </div>
                

                <!--Img Col-->
                <div class="w-full lg:w-2/5">
                    <!-- Big profile image for side bar (desktop) -->
                    <cfif NOT isNull(user.pfp)>
                        <img src="#user.pfp#" class="rounded-none lg:rounded-lg shadow-2xl hidden lg:block">
                        <cfelse>
                            <img src="/ecommerce-store/assets/default_avatar.jpg" class="rounded-none lg:rounded-lg shadow-2xl hidden lg:block">
                    </cfif>

                        <label class="block">
                        <span class="sr-only">Choose profile photo</span>
                        <input id="pfp" name="pfp" type="file" class="block w-full text-sm text-gray-500
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
                <button id="update" type="submit" class="bg-dark-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded-full">
                    Update
                </button>



                <!-- Pin to top right corner -->
                <div class="absolute top-0 right-0 h-12 w-18 p-4">
                    <button type="button" class="js-change-theme focus:outline-none">🌙</button>
                </div>

            </div>
    </body>
</form>

</cfoutput>

    <script src="https://unpkg.com/popper.js@1/dist/umd/popper.min.js"></script>
    <script src="https://unpkg.com/tippy.js@4"></script>
    <script>
        //Init tooltips
		tippy('.link',{
		  placement: 'bottom'
		})

		//Toggle mode
		const toggle = document.querySelector('.js-change-theme');
		const body = document.querySelector('body');
		const profile = document.getElementById('profile');
		
		
		toggle.addEventListener('click', () => {

		  if (body.classList.contains('text-gray-900')) {
			toggle.innerHTML = "☀️";
			body.classList.remove('text-gray-900');
			body.classList.add('text-gray-100');
			profile.classList.remove('bg-white');
			profile.classList.add('bg-gray-900');
		  } else
		  {
			toggle.innerHTML = "🌙";
			body.classList.remove('text-gray-100');
			body.classList.add('text-gray-900');
			profile.classList.remove('bg-gray-900');			
			profile.classList.add('bg-white');
			
		  }
		});

        $(document).ready(function(){
        $('#updateProfile').on('submit', function(e){
            e.preventDefault();
            var name = $("#name").text();
            var email = $("#email").text();
            var pfp = $("#pfp").val();
            var description = $("#description").text();
            var formData = new FormData($('#updateProfile')[0]);
            formData.append("name",name);
            formData.append("email",email);
            formData.append("description",description);
            var token = JSON.parse($.cookie("auth_token"));
            var request = $.ajax({
                url: "/ecommerce-store/profile/profile.cfc?method=update",
                headers: {
                    "Authorization": token
                },
                type: "POST",
                data: formData,
                contentType: false,
                processData: false
                });

                request.done(function(msg) {
                    console.log(msg);
                });

                request.fail(function(jqXHR, textStatus) {
                alert( "Request failed: " + textStatus );
            });
        });
    });
		
    </script>

</body>