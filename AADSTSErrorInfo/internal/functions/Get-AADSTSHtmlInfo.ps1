Function Get-AADSTSHtmlInfo{
<#
        .SYNOPSIS   Gets all the text in HTML tables on a webpage and returns it as an object of arrays
        .DESCRIPTION
            This function treats 
                1. table cells as properties of row objects
                2. Rows as custom objects with cells as properties
                3. Tables as arrays of rows
                4. Pages as custom objects with numbered tables as properties.
            Returns
                -Custom object with numbered properties
                -Each numbered property represents a table number from the top of the page down
                -Each numbered property contains an array of row custom objects
                -Each object in the array has properties representing each cell in the row.
	.NOTES
		Original Script source:  #https://sysjam.wordpress.com/2016/01/08/consuming-html-tables-with-powershell/
        .PARAMETER URL
            The URL to look for HTML tables in
        .PARAMETER FirstRowHeader
            Whether or not to treat the first row of the table as a header
        .EXAMPLE
            $objPage = Get-HTMLTables -URL 'https://support.microsoft.com/en-us/lifecycle/search?sort=PN&alpha=windows%2010&Filter=FilterNO' -FirstRowHeader $true
        .EXAMPLE
            $objPage.21 | select -first 1
                            
            Extended Support End Date     : 10/14/2025
            Lifecycle Start Date          : 7/29/2015
            Products Released             : Visual Studio Express 2015 for Windows 10
            Mainstream Support End Date   : 10/13/2020
            Service Pack Support End Date : 
            Notes                         : 
        .EXAMPLE
            $objPage.21 | Where{$_.('Products Released') -match 'Education'}
             
            Extended Support End Date     : 10/14/2025
            Lifecycle Start Date          : 7/29/2015
            Products Released             : Windows 10 Education, released in July 2015
            Mainstream Support End Date   : 10/13/2020
            Service Pack Support End Date : 
            Notes : • Updates are cumulative, with each update built upon all of the updates that preceded it. A device needs to 
                    install the latest update to remain supported. 
                    • Updates may include new features, fixes (security and/or non-security), or a combination of both. Not all 
                    features in an update will work on all devices. 
                    • A device may not be able to receive updates if the device hardware is incompatible, lacking current 
                    drivers, or otherwise outside of the Original Equipment Manufacturer’s (“OEM”) support period. 
                    • Update availability may vary, for example by country, region, network connectivity, mobile operator (e.g., 
                    for cellular-capable devices), or hardware capabilities (including, e.g., free disk space).  
#>
Param(
    $page
)
    
 
#Get the webpage
 
#Filter out only the tables
$tables = $page.ParsedHtml.body.getElementsByTagName('Table')
 
#Get only the tables that have cells
$tableswithcells = $tables | Where{$_.cells}
$hashPage = @{}
$tablecount = 0
 
#ForEach table
ForEach($table in $tableswithcells){
    $arrTable = @()
    $rownum = 0
    $arrTableHeader = @()
    #Get all the rows in the tables
    ForEach($row in $table.rows){
        #Treat the first row as a header
        if($rownum -eq 0 -and $firstRowHeader){
            ForEach($cell in $row.cells){
                $arrTableHeader += $cell.InnerText.Trim()
            }
            #If not the first row, but using headers, store the value by header name
        }elseIf($firstRowHeader){
            $cellnum = 0
            $hashRow = @{}
            ForEach($cell in $row.cells){
                $strHeader = $arrTableHeader[$cellNum]
                If($strHeader){
                    $hashRow.Add($strHeader,$cell.innertext)
                }else{
                    #If the header is null store it by cell number instead
                    $hashRow.Add($cellnum,$cell.innertext)
                }
                $cellnum++
            }
            #Save the row as a custom ps object
            $objRow = New-object -TypeName PSCustomObject -Property $hashRow
            $arrTable += $objRow
            #if not the first row and not using headers, store the value by cell index
        }else{
            $cellnum = 0
            $hashRow = @{}
            ForEach($cell in $row.cells){
                $hashRow.Add($cellnum,$cell.innertext)
                $cellnum++
            }
            #Store the row as a custom object
            $objRow = New-object -TypeName PSCustomObject -Property $hashRow
 
            #Add the row to the array of rows
            $arrTable += $objRow
        }
        $rownum++
    }
    #Add the tables to the hashtable of tables
    $hashPage.Add($tablecount,$arrTable)
    $tablecount++
}
$objPage = New-object -TypeName PSCustomObject -Property $hashPage
Return $objPage
}
