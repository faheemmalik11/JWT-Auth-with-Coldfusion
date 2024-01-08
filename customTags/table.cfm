    <!-- component -->
    <!DOCTYPE html>
    <html lang="en" class="antialiased">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>DataTables </title>
        <meta name="description" content="">
        <meta name="keywords" content="">
        <link href="https://unpkg.com/tailwindcss@2.2.19/dist/tailwind.min.css" rel=" stylesheet">
        <!--Replace with your tailwind.css once created-->
    
    
        <!--Regular Datatables CSS-->
        <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
        <!--Responsive Extension Datatables CSS-->
        <link href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css" rel="stylesheet">
    
        <style>
            /*Overrides for Tailwind CSS */
    
            /*Form fields*/
            .dataTables_wrapper select,
            .dataTables_wrapper .dataTables_filter input {
                color: #4a5568;
                /*text-gray-700*/
                padding-left: 1rem;
                /*pl-4*/
                padding-right: 1rem;
                /*pl-4*/
                padding-top: .5rem;
                /*pl-2*/
                padding-bottom: .5rem;
                /*pl-2*/
                line-height: 1.25;
                /*leading-tight*/
                border-width: 2px;
                /*border-2*/
                border-radius: .25rem;
                border-color: #edf2f7;
                /*border-gray-200*/
                background-color: #edf2f7;
                /*bg-gray-200*/
            }
    
            /*Row Hover*/
            table.dataTable.hover tbody tr:hover,
            table.dataTable.display tbody tr:hover {
                background-color: #ebf4ff;
                /*bg-indigo-100*/
            }
    
            /*Pagination Buttons*/
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                font-weight: 700;
                /*font-bold*/
                border-radius: .25rem;
                /*rounded*/
                border: 1px solid transparent;
                /*border border-transparent*/
            }
    
            /*Pagination Buttons - Current selected */
            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                color: #fff !important;
                /*text-white*/
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, .1), 0 1px 2px 0 rgba(0, 0, 0, .06);
                /*shadow*/
                font-weight: 700;
                /*font-bold*/
                border-radius: .25rem;
                /*rounded*/
                background: #667eea !important;
                /*bg-indigo-500*/
                border: 1px solid transparent;
                /*border border-transparent*/
            }
    
            /*Pagination Buttons - Hover */
            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                color: #fff !important;
                /*text-white*/
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, .1), 0 1px 2px 0 rgba(0, 0, 0, .06);
                /*shadow*/
                font-weight: 700;
                /*font-bold*/
                border-radius: .25rem;
                /*rounded*/
                background: #667eea !important;
                /*bg-indigo-500*/
                border: 1px solid transparent;
                /*border border-transparent*/
            }
    
            /*Add padding to bottom border */
            table.dataTable.no-footer {
                border-bottom: 1px solid #e2e8f0;
                /*border-b-1 border-gray-300*/
                margin-top: 0.75em;
                margin-bottom: 0.75em;
            }
    
            /*Change colour of responsive icon*/
            table.dataTable.dtr-inline.collapsed>tbody>tr>td:first-child:before,
            table.dataTable.dtr-inline.collapsed>tbody>tr>th:first-child:before {
                background-color: #667eea !important;
                /*bg-indigo-500*/
            }
        </style>
    </head>
    <cfparam  name="#attributes.dir#" default="">
                <cfoutput>
                    <table id="example" class="stripe hover" style="width:100%; padding-top: 1em;  padding-bottom: 1em;" >
                        <thead>
                            <tr>
                                <cfloop array = "#ATTRIBUTES.data.getColumnList()#" index = columnName >
                                    <th>#columnName#</th>
                                </cfloop>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="#attributes.data#">
                                <tr>
                                    <cfloop array = "#ATTRIBUTES.data.getColumnList()#" index = columnName >
                                        <cfif attributes.data[columnName][attributes.data.currentRow] NEQ ImagePath >
                                            <td>#attributes.data[columnName][attributes.data.currentRow]#</td>
                                            <cfelse>
                                                <td>
                                                    <cfif len(trim(#attributes.data[columnName][attributes.data.currentRow]#)) gt 0 >
                                                            <img src="#attributes.data[columnName][attributes.data.currentRow]#" width= "100" height="75">
                                                            <cfelse>
                                                                <img src="/ecommerce-store/assets/default.jpg" width= "100" height="75">
                                                    </cfif>
                                                </td>
                                        </cfif>
                                    </cfloop>
                                    <td>
                                        <a href="/ecommerce-store/#attributes.dir#/update.cfm?id=#id#" >
                                            <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 1" viewBox="0 0 24 24" id="edit" width="50" height="50"><path d="M3.5,24h15A3.51,3.51,0,0,0,22,20.487V12.95a1,1,0,0,0-2,0v7.537A1.508,1.508,0,0,1,18.5,22H3.5A1.508,1.508,0,0,1,2,20.487V5.513A1.508,1.508,0,0,1,3.5,4H11a1,1,0,0,0,0-2H3.5A3.51,3.51,0,0,0,0,5.513V20.487A3.51,3.51,0,0,0,3.5,24Z"></path><path d="M9.455,10.544l-.789,3.614a1,1,0,0,0,.271.921,1.038,1.038,0,0,0,.92.269l3.606-.791a1,1,0,0,0,.494-.271l9.114-9.114a3,3,0,0,0,0-4.243,3.07,3.07,0,0,0-4.242,0l-9.1,9.123A1,1,0,0,0,9.455,10.544Zm10.788-8.2a1.022,1.022,0,0,1,1.414,0,1.009,1.009,0,0,1,0,1.413l-.707.707L19.536,3.05Zm-8.9,8.914,6.774-6.791,1.4,1.407-6.777,6.793-1.795.394Z"></path></svg>
                                        </a>
                                    </td>
                                    <td>
                                        <button type="button" class="deleteIcon" data-id="#id#">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" id="delete" width="50" height="50">
                                            <path d="M24.2,12.193L23.8,24.3a3.988,3.988,0,0,1-4,3.857H12.2a3.988,3.988,0,0,1-4-3.853L7.8,12.193a1,1,0,0,1,2-.066l.4,12.11a2,2,0,0,0,2,1.923h7.6a2,2,0,0,0,2-1.927l.4-12.106a1,1,0,0,1,2,.066Zm1.323-4.029a1,1,0,0,1-1,1H7.478a1,1,0,0,1,0-2h3.1a1.276,1.276,0,0,0,1.273-1.148,2.991,2.991,0,0,1,2.984-2.694h2.33a2.991,2.991,0,0,1,2.984,2.694,1.276,1.276,0,0,0,1.273,1.148h3.1A1,1,0,0,1,25.522,8.164Zm-11.936-1h4.828a3.3,3.3,0,0,1-.255-.944,1,1,0,0,0-.994-.9h-2.33a1,1,0,0,0-.994.9A3.3,3.3,0,0,1,13.586,7.164Zm1.007,15.151V13.8a1,1,0,0,0-2,0v8.519a1,1,0,0,0,2,0Zm4.814,0V13.8a1,1,0,0,0-2,0v8.519a1,1,0,0,0,2,0Z"></path>
                                            </svg>
                                        </button>
                                    </td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </cfoutput>

        <!--Datatables -->
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
        <script>
            $(document).ready(function() {
                var table = $('#example').DataTable({
                        responsive: false
                    })
                    .columns.adjust()
                    .responsive.recalc();
            });

            var token = JSON.parse($.cookie("auth_token"));
                var dir = "<cfoutput>#attributes.dir#</cfoutput>";

                $(".deleteIcon").click(function(){
                        var id = $(this).data("id");
                        Swal.fire({
                            title: "Are you sure?",
                            text: "You won't be able to revert this!",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Yes, delete it!"
                            }).then((result) => {
                            if (result.isConfirmed) {
                                var request = $.ajax({
                                    url: "/ecommerce-store/"+dir+"/"+dir+".cfc?method=delete",
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
                                        if(parsed.CODE == 200){
                                            Swal.fire({
                                                title: "Deleted!",
                                                text: parsed.MESSAGE,
                                                icon: "success"
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

                            }
                        });

                    })


        </script>
    </html>