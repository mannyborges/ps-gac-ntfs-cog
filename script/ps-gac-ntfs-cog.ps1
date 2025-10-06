
<#
     => To make this script into an EXE <=
     
Short:
    Run the Build script 
Longer: 
     Install-Module -Name ps2exe 
     Start-Process "C:\Program Files\WindowsPowerShell\Modules\ps2exe\<version>\Win-PS2EXE.exe"
     Use the GUI tool and fill in all the values appropriately
     .manny
#>
function Set-GAC-ACL (){
         param(  # used param becasue I wanted to validate the inout instead of just taking whatever for the action 
           [Parameter(Mandatory)]
           [ValidateSet("Add","Remove")]
           [string]$Action,
           [Parameter(Mandatory)]
           [string]$user
           )

         # Define the path to the file or folder
         $Paths = @("C:\Windows\Microsoft.NET\assembly\GAC_32",
                    "C:\Windows\Microsoft.NET\assembly\GAC_64")
         $Permission = "Write"
         # Define the user or group to add (e.g., "DOMAIN\User" or "UserName")
         foreach ($path in $Paths) {
            # Get the current ACL of the file or folder
            $Acl = Get-Acl -Path $Path
            # Create a new FileSystemAccessRule for the user
            
            $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
                $user,
                $Permission,
                "ContainerInherit,ObjectInherit", # Applies to subfolders and files
                "None",                           # No special propagation flags
                "Allow"                           # Allow the permission
            ) 
            # Add the new access rule to the ACL
            <# DONE - look at using remove access rule and a switch or make a new function to format the method correctly  #>
            switch ($Action) {   
                "Add" { $Acl.AddAccessRule($AccessRule) | Out-Null  }
                "Remove" { $acl.RemoveAccessRule($AccessRule) | Out-Null  }
                Default {write-host "Something went horribly terribly wrong . It is probably your fault. "}
            } 
            #$acl.
            # Apply the updated ACL back to the file or folder
            Set-Acl -Path $Path -AclObject $Acl
            Write-Host ("Successfully Completed {0}  {1} permission to {2} on {3}" -f $action, 
                                                                                      $Permission, 
                                                                                      $user, 
                                                                                      $Path )
         }
}
function main (){
    #$user = "Users" # thats the internal local group group, but I reccomend targeting the  logged in user 
    $user = whoami.exe  # this works well and restricts the change to the user who runs it .
    Set-GAC-ACL -Action Add -user $user
    Start-Process explorer.exe -ArgumentList 'C:\Windows\Microsoft.NET\assembly\' 
    Write-host "WHEN YOU CLOSE THIS -  It WILL REMOVE THE PERMISSIONS " -ForegroundColor Red -BackgroundColor  Gray 
    Set-GAC-ACL -Action Remove -user $user
 
    }
#Pause
 
main



#   C:\GitHubLOCALONLY\ps-gac-ntfs-cog\script\setntfsacl.ps1