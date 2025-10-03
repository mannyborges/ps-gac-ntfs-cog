<#
ps2exe [-inputFile] '<file_name>' [[-outputFile] '<file_name>']
       [-prepareDebug] [-x86|-x64] [-lcid <id>] [-STA|-MTA] [-noConsole] [-conHost] [-UNICODEEncoding]
       [-credentialGUI] [-iconFile '<filename>'] [-$embedFiles <hashtable>] [-title '<title>'] [-description '<description>']
       [-company '<company>'] [-product '<product>'] [-copyright '<copyright>'] [-trademark '<trademark>']
       [-version '<version>'] [-configFile] [-noOutput] [-noError] [-noVisualStyles] [-exitOnCancel]
       [-DPIAware] [-requireAdmin] [-supportOS] [-virtualize] [-longPaths]

      inputFile = Powershell script that you want to convert to executable (file has to be UTF8 or UTF16 encoded)
     outputFile = destination executable file name or folder, defaults to inputFile with extension '.exe'
   prepareDebug = create helpful information for debugging    
     x86 or x64 = compile for 32-bit or 64-bit runtime only
           lcid = location ID for the compiled executable. Current user culture if not specified
     STA or MTA = 'Single Thread Apartment' or 'Multi Thread Apartment' mode
      noConsole = the resulting executable will be a Windows Forms app without a console window
        conHost = force start with conhost as console instead of Windows Terminal (disables redirections)
UNICODEEncoding = encode output as UNICODE in console mode
  credentialGUI = use GUI for prompting credentials in console mode
       iconFile = icon file name for the compiled executable
     embedFiles = files to embed given as hash, will be extracted to key of hash, source file names must be unique
                  (e.g. -embedFiles @{'Targetfilepath'='Sourcefilepath'} )
          title = title information (displayed in details tab of Windows Explorer's properties dialog)
    description = description information (not displayed, but embedded in executable)
        company = company information (not displayed, but embedded in executable)
        product = product information (displayed in details tab of Windows Explorer's properties dialog)
      copyright = copyright information (displayed in details tab of Windows Explorer's properties dialog)
      trademark = trademark information (displayed in details tab of Windows Explorer's properties dialog)
        version = version information (displayed in details tab of Windows Explorer's properties dialog)
     configFile = write config file (<outputfile>.exe.config)
       noOutput = the resulting executable will generate no standard output (includes verbose and information channel)
        noError = the resulting executable will generate no error output (includes warning and debug channel)
 noVisualStyles = disable visual styles for a generated windows GUI application (only with -noConsole)
   exitOnCancel = exits program when Cancel or "X" is selected in a Read-Host input box (only with -noConsole)
       DPIAware = if display scaling is activated, GUI controls will be scaled if possible (only with -noConsole)
   requireAdmin = if UAC is enabled, compiled executable run only in elevated context (UAC dialog appears if required)
      supportOS = use functions of newest Windows versions (execute [Environment]::OSVersion to see the difference)
     virtualize = application virtualization is activated (forcing x86 runtime)
      longPaths = enable long paths ( > 260 characters) if enabled on OS (works only with Windows 10      
#>

function Move-OldBuild {
<# for now I am wiping them out
Later we can look at adding a timestamp and moving them to archive or using jenkins and doing an actual cersioned build #>

}
 function MAIN () {
$WorkingDirectory = 
$scriptPath = 
$buildLocation = 
$FileName = 

$go = [PSCustomObject]@{  # update your properties and add new ones in this block
    WorkingDirectory = "..\..\\ps-gac-ntfs-cog\"
    BuildLocation = "build\"
    FilePath = "script\"
    FileName = "setntfsacl"
    title = "Secops tool - GAC NTSF Modifier - .manny" # this is displayed on the action windows
    description = "Sets NTFS Permissions on the GAC 32 and 64"
    company = "Cognex"
}

$in = $go.WorkingDirectory + $go.FilePath + $go.FileName + ".ps1"
$out = $go.WorkingDirectory + $go.BuildLocation + $go.FileName + ".exe"
if (Test-Path $out)
   {remove-item -path $out -Force   }
Invoke-ps2exe -inputFile $in -outputFile $out -company $go.company -description $go.title -title $go.company -noConsole

 }
 main