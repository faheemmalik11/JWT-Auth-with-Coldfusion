
<cfinvoke method="selectCategories" component="/ecommerce-store/products/products"  returnvariable="categories">
  <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse relative">
    <button id="dropDownButton" type="button" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700" aria-expanded="false" data-dropdown-toggle="user-dropdown" data-dropdown-placement="bottom">
        Select Category
    </button>
  
      <!-- Dropdown menu -->
      <cfoutput >
                

    <div class="z-50 absolute bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700 hidden" id="dropDown" style="top: 2.5rem;">
        <ul class="text-sm text-gray-700 dark:text-gray-200" aria-labelledby="dropdownHoverButton">
            <li>
                <a href="/ecommerce-store/dashboard/index.cfm" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">All</a>
            </li>  
            <cfloop query="categories" >
                <li>
                    <a href="/ecommerce-store/dashboard/index.cfm?category=#id#" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">#CategoryName#</a>
                </li>        
            </cfloop>
            
          </ul>
    </div>
</cfoutput>
</div>
