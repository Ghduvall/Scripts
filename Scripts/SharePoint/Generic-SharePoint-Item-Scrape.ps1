# Script for scraping entire SharePoint Site with Office Admin Credentials
# Scroll down to Paramaters to set what site to scrape with url and where to store the file with CSVReport

# Link used for setup https://www.sharepointdiary.com/2018/08/sharepoint-online-powershell-to-get-all-files-in-document-library.html#:~:text=Use%20the%20PnP%20PowerShell%20cmdlet,name%20and%20server%20relative%20path.

# Before runing make sure you run PowerShell with Admin and that you have PnP.PowerShell installed
# Go to this link if you have any errors https://www.sharepointdiary.com/2021/04/connect-pnponline-command-was-found-in-module-pnp-powershell-but-module-could-not-be-loaded.html



#Function to collect site Inventory
Function Get-PnPSiteInventory
{
[cmdletbinding()]
   param([parameter(Mandatory = $true, ValueFromPipeline = $true)] $Web)
 
    #Skip Apps
    If($Web.url -notlike "$SiteURL*") { return }
    
    Write-host "Getting Site Inventory from Site '$($Web.URL)'" -f Yellow
  
    #Exclude certain libraries
    $ExcludedLists = @("Form Templates", "Preservation Hold Library")
                                
    #Get All Document Libraries from the Web
    $Lists= Get-PnPProperty -ClientObject $Web -Property Lists
    $Lists | Where-Object {$_.BaseType -eq "DocumentLibrary" -and $_.Hidden -eq $false -and $_.Title -notin $ExcludedLists -and $_.ItemCount -gt 0} -PipelineVariable List | ForEach-Object {
        #Get Items from List  
        $global:counter = 0;
        $ListItems = Get-PnPListItem -List $_ -PageSize $Pagesize -Fields Author, Created -ScriptBlock `
                 { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete ($global:Counter / ($_.ItemCount) * 100) -Activity "Getting Inventory from '$($_.Title)'" -Status "Processing Items $global:Counter to $($_.ItemCount)";}
        Write-Progress -Activity "Completed Retrieving Inventory from Library $($List.Title)" -Completed
      
            #Get Root folder of the List
            $Folder = Get-PnPProperty -ClientObject $_ -Property RootFolder
             
            $SiteInventory = @()
            #Iterate through each Item and collect data          
            ForEach($ListItem in $ListItems)
            { 
                #Collect item data
                $SiteInventory += New-Object PSObject -Property ([ordered]@{
                    SiteName  = $Web.Title
                    SiteURL  = $Web.URL
                    LibraryName = $List.Title
                    ParentFolderURL = $Folder.ServerRelativeURL
                    Name = $ListItem.FieldValues.FileLeafRef
                    Type = $ListItem.FileSystemObjectType
                    ItemRelativeURL = $ListItem.FieldValues.FileRef
                    CreatedBy = $ListItem.FieldValues.Author.Email
                    CreatedAt = $ListItem.FieldValues.Created
                    ModifiedBy = $ListItem.FieldValues.Editor.Email
                    ModifiedAt = $ListItem.FieldValues.Modified
                })
            }
            #Export the result to CSV file
            $SiteInventory | Export-CSV $CSVReport -NoTypeInformation -Append
        }
}
 
#Parameters
# Change url and CSVReport below
$SiteURL = "https://allanedwardstulsa.sharepoint.com"
$CSVReport = "C:\Users\GrantDuvall\OneDrive - NSN Management, LLC\Documents\SiteInventory.csv"

$Pagesize = 2000
 
#Connect to Site collection
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Delete the Output Report, if exists
If (Test-Path $CSVReport) { Remove-Item $CSVReport }   
   
#Call the Function for all Webs
Get-PnPSubWeb -Recurse -IncludeRootWeb | ForEach-Object { Get-PnPSiteInventory $_ }
    
Write-host "Site Inventory Report has been Exported to '$CSVReport'"  -f Green


#Read more: https://www.sharepointdiary.com/2019/10/sharepoint-online-site-documents-inventory-report-using-powershell.html#ixzz8GhJ13bxP