On Error Resume Next  

Const HKCU   = &h80000001
Const HKLM   = &H80000002
Const strKeyPath = "Software\Microsoft\Windows\CurrentVersion\Uninstall\"
Const str64KeyPath = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

'FilePath  = "\\Server-File\PCSoftList\"
FilePath  = CreateObject("Scripting.FileSystemObject").GetFolder(".").Path & "\"
Set Wshell   = CreateObject("Wscript.Shell")
Set objFSO   = CreateObject("Scripting.FileSystemobject")

'Set collected computers Name
set argus=wscript.arguments
if argus.count=0 then
 strComputerName = Wshell.RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Hostname")
else
 strComputerName = argus(0)
end if

Set textWriteFile = objFSO.OpenTextFile(FilePath & ucase(strComputerName) &".txt",ForWriting,True,True)

Set objReg = GetObject("winmgmts://" & strComputerName & "/root/default:StdRegProv")

'Get OS Version
intRet = objReg.GetStringValue(HKLM, "SOFTWARE\Microsoft\Windows NT\CurrentVersion","ProductName",strOSVersion)
If intRet = 0 Then
 intRet = objReg.GetStringValue(HKLM, "SOFTWARE\Microsoft\Windows NT\CurrentVersion","CSDVersion",strOSServicePack)
 intRet = objReg.GetStringValue(HKLM, "SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion","ProductName",str64BitOSVersion)
 if intRet = 0 then
  strOSVersion = strOSVersion & " 64bit"
 end if
 intRet = objReg.GetStringValue(HKLM, "SYSTEM\CurrentControlSet\Control\Nls\Language","InstallLanguage",OSLanguageCode)
 if intRet = 0 then
  select case OSLanguageCode
  case "0804" '中文
   strOSVersion = strOSVersion & " Chinese Version"
  case "0411" '日文
   strOSVersion = strOSVersion & " Japanese Version"
  case "0409" '英文
   strOSVersion = strOSVersion & " English Version"
  case else '未知语言
   strOSVersion = strOSVersion & " UnknownLanguage Version"
  end select
 end if
Else
 strOSVersion = "OS Get Failed"
 strOSServicePack = "NoFind"
End If
if InStr(LCase(strOSVersion),"windows")>0 then
 textWriteFile.WriteLine("""" & ucase(strComputerName) & """" & vbTab & """" & strOSVersion & """" & vbTab & """" & strOSServicePack & """")
end if

'Display User Software.
objReg.EnumKey HKCU, strKeyPath,arrSubKeys
For Each strSubKey In arrSubKeys
 intGet = objReg.GetDWORDValue(HKCU, strKeyPath & strSubKey,"SystemComponent",intSystemComponent)
 If IsNull(intSystemComponent) then
  intSystemComponent = 0
 End If
 intRet = objReg.GetStringValue(HKCU, strKeyPath & strSubKey,"ParentDisplayName",strName)
 If intSystemComponent = 0 and intRet > 0 then
  intRet = objReg.GetStringValue(HKCU, strKeyPath & strSubKey,"DisplayName",strName)
  If strName <> "" And intRet = 0 And ignorePgm(strName) Then
   strName = replace(replace(strName,vbCrLf,""),vbTab,"")
   intRet = objReg.GetStringValue(HKCU, strKeyPath & strSubKey,"DisplayVersion",strVersion)
   textWriteFile.WriteLine("""" & ucase(strComputerName) & """" & vbTab & """" & strName & """" & vbTab & """" & strVersion & """")
  End If
 End If
Next

'Display Machine 32bit Software.
objReg.EnumKey HKLM, strKeyPath,arrSubKeys
For Each strSubKey In arrSubKeys
 intGet = objReg.GetDWORDValue(HKLM, strKeyPath & strSubKey,"SystemComponent",intSystemComponent)
 If IsNull(intSystemComponent) then
  intSystemComponent = 0
 End If
 intRet = objReg.GetStringValue(HKLM, strKeyPath & strSubKey,"ParentDisplayName",strName)
 If intSystemComponent = 0 and intRet > 0 then
  intRet = objReg.GetStringValue(HKLM, strKeyPath & strSubKey,"DisplayName",strName)
  If strName <> "" And intRet = 0 And ignorePgm(strName) Then '
   strName = replace(replace(strName,vbCrLf,""),vbTab,"")
   intRet = objReg.GetStringValue(HKLM, strKeyPath & strSubKey,"DisplayVersion",strVersion)
   textWriteFile.WriteLine("""" & ucase(strComputerName) & """" & vbTab & """" & strName & """" & vbTab & """" & strVersion & """")
  End If
 End If
Next

'Display Machine 64bit Software.
objReg.EnumKey HKLM, str64KeyPath,arrSubKeys
For Each strSubKey In arrSubKeys
 intGet = objReg.GetDWORDValue(HKLM, str64KeyPath & strSubKey,"SystemComponent",intSystemComponent)
 If IsNull(intSystemComponent) then
  intSystemComponent = 0
 End If
 intRet = objReg.GetStringValue(HKLM, str64KeyPath & strSubKey,"ParentDisplayName",strName)
 If intSystemComponent = 0 and intRet > 0 then
  intRet = objReg.GetStringValue(HKLM, str64KeyPath & strSubKey,"DisplayName",strName)
  If strName <> "" And intRet = 0 And ignorePgm(strName) Then
   strName = replace(replace(strName,vbCrLf,""),vbTab,"")
   intRet = objReg.GetStringValue(HKLM, str64KeyPath & strSubKey,"DisplayVersion",strVersion)
   textWriteFile.WriteLine("""" & ucase(strComputerName) & """" & vbTab & """" & strName & """" & vbTab & """" & strVersion & """")
  End If
 End If
Next

textWriteFile.Close

function ignorePgm(strPgm)
 If inStr(1,strPgm,"Microsoft Office ",1)<=0 then
  '不输出Security Update、.NET Framework、Microsoft Visual C++、NVIDIA、Intel(R)的程序
  ignorePgm = inStr(1,strPgm,"Security Update",1)<=0 _
   And inStr(1,strPgm,".NET Framework",1)<=0 _
   And inStr(1,strPgm,"Microsoft Visual C++",1)<=0 _
   And inStr(1,strPgm,"NVIDIA",1)<=0 _
   And inStr(1,strPgm,"Intel(R)",1)<=0
 Else
  '让个版本的Office能正常输出
  ignorePgm = inStr(1,strPgm,"Microsoft Office ",1)>0 _
     And (inStr(1,strPgm," 2000 ",1)>0 _
      Or inStr(1,strPgm," 2003 ",1)>0 _
      Or (inStr(1,strPgm,"Microsoft Office Access ",1)=1 And inStr(1,strPgm," MUI",1)<=0) _
      Or strPgm="Microsoft Office Professional Plus 2007" _
      Or strPgm="Microsoft Office Professional Plus 2010" _
      Or strPgm="Microsoft Office Professional Plus 2016" _
      Or strPgm="Microsoft Office Standard 2007" _
      Or strPgm="Microsoft Office Standard 2010" _
      Or strPgm="Microsoft Office Standard 2016" _
      Or strPgm="Microsoft Office Standard 2019")

 End If
end function