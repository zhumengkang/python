Const MyName = "WindowsӲ�����ӹ���(������) --by:Rex.Pack(����ר��)"

If Not LCase(Replace(WScript.FullName, WScript.Path & "\", "")) = "cscript.exe" Then
	Set WS = CreateObject("WScript.Shell")
	WS.Run "CMD /c mode con: cols=115 & Color 0A & Title " & MyName & " & CScript //nologo """ & WScript.ScriptFullName & """"
	WScript.Quit
End If
'----��ʼ��
Set SD = CreateObject("Scripting.Dictionary")
	SD.CompareMode = vbTextCompare
Set S = New BaseStr
Set PC = New BasePC
Set WMI = GetObject("Winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
CmdArr = Split(" OS CPU Board Memory Video Disk USB CacheMemory NetWork BIOS Sound Battery PortableBattery" & " S1 S2 S3 S4")
With SD
	.Add "?", "Call Menu"
	.Add "e", "WScript.Quit"
	For I = 1 To 17
		.Add CStr(I), CmdArr(I)
	Next
	.Add "a", "1-6"
	.Add "b", "7-9"
	.Add "c", "10-13"
	.Add "d", "14-17"
End With

Echo MyName

Call Menu
Call Main


'----CO
Sub Menu()
	Echo "[�豸�б�]"
	Echo " ������ A: 1.OS	2.CPU	3.����	4.�ڴ�	5.�Կ�	6.Ӳ��"
	Echo " �μ��� B: 7.USB	8.����	9.����"
	Echo " ������ C: 10.BIOS	11.����	���(12.�ڲ� 13.��Я)"
	Echo "[����CPU]"
	Echo " ������ D: 14.�����ݴη�����	15.�ַ�����	16.�ӷ�����	17.���Ӽ���"
End Sub

Sub Main()
	Print ">": GetNum = Trim(InPut)
	With SD
		If .Exists(GetNum) Then
			If IsNumeric(GetNum) Then
				Echo Eval("PC." & .Item(GetNum))
			Else
				ArrLU = Split(.Item(GetNum), "-")
				For L = ArrLU(0) To ArrLU(1)
					Echo Eval("PC." & .Item(CStr(L)))
				Next
			End If
		Else
			Echo "#��֧�ֵ�����"
		End If
	End With
	
	If Not Err.Number = 0 Then Echo ">X": Err.Clear
	Call Main
End Sub



'DDC
Class BaseStr
	Private Strs
	
	Private Sub Class_Initialize()
		Strs = ""
	End Sub
	
	Private Sub Class_Terminate()
		Call Cls
	End Sub
	
	Public Sub Cls()
		Strs = Empty
	End Sub
	
	Public Property Let I(ByVal Str)
		If Left(Str, 1) = "��" Then Str = Str & String(80, "=")
		Strs = Strs & vbCrLf & Str
	End Property
	
	Public Default Property Get I()
		I = Strs
		Cls
	End Property
End Class

Class BasePC
	Private DPS
	
	Private Sub Class_Initialize()
		DPS = 200
	End Sub
	
	Private Sub Class_Terminate()
		DPS = Empty
	End Sub
	
	Function S1()
		S1 = "�����ݴη����� " & DPS & "�����ʱ:" & RT("TestVar = I ^ 2", DPS * 10000)
	End Function
	
	Function S2()
		S2 = "�ַ����� " & DPS & "000����ʱ:" & RT("TestVar = TestVar & vbTab", DPS * 1000)
	End Function
	
	Function S3()
		S3 = "�ӷ����� " & DPS & "�����ʱ:" & RT("TestVar = 86 + 32", DPS * 10000)
	End Function
	
	Function S4()
		S4 = "���Ӽ��� " & DPS & "�����ʱ:" & RT("TestVar = TestVar + I", DPS * 10000)
	End Function
	
	Private Function RT(ByVal MathExp, ByVal Num)
		Dim NowTimer, NewTimer, TestVar
		NowTimer = Timer
		For I = 1 To Num
			ExeCute MathExp
		Next
		NewTimer = FormatNumber((Timer - NowTimer) * 1000, 3, True, , False) & "ms"
		RT = NewTimer
		TestVar = Empty
	End Function
	
	Function BIOS()
		On Error Resume Next
		S.I = "��[BIOS]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_BIOS")
			With TempObj
				S.I = "�ǳ���		:" & .Manufacturer
				S.I = "������		:" & .ReleaseDate
				S.I = "��OEM �汾	:" & .Version
				S.I = "��BIOS �汾	:" & .SMBIOSBIOSVersion
				S.I = "��Major�汾	:" & .SMBIOSMajorVersion
				S.I = "��״̬		:" & .Status
			End With
		Next
		S.I = "������������������������������"
		BIOS = S
	End Function

	Function OS()
		On Error Resume Next
		S.I = "��[����ϵͳ]"
		S.I = "������������������������������"
		For Each TempObj in WMI.InstancesOf("Win32_OperatingSystem")
			With TempObj
				S.I = "�Ǳ�ǩ  :" & .Caption
				S.I = "��CSDV  :" & .CSDVersion
				S.I = "���汾  :" & .Version
				S.I = "��RAMʶ��:" & .TotalVisibleMemorySize / 1024 & "MB"
				S.I = "��RAM����:" & .FreePhysicalMemory / 1024 & "MB"
			End With
		Next
		S.I = "������������������������������"
		OS = S
	End Function
	
	Function Board()
		On Error Resume Next
		S.I = "��[����]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_BaseBoard")
			With TempObj
				S.I = "�Ǳ�ǩ:" & .Caption
				S.I = "�����:" & .Product
				S.I = "�����:" & .SerialNumber 
				S.I = "������:" & .Name
				S.I = "���汾:" & .Version
				S.I = "������:" & .Manufacturer
				S.I = "��״̬:" & .Status
			End With
		Next
		S.I = "������������������������������"
		Board = S
	End Function
	
	Function CPU()
		On Error Resume Next
		S.I = "��[CPU]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_Processor")
			With TempObj
				MCS = .MaxClockSpeed
				CCS = .CurrentClockSpeed
				If MCS Mod 2 = 1 Then MCS = CCS + 1
				If CCS Mod 2 = 1 Then CCS = CCS + 1
				If CCS = MCS Then
					Set SRP = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
					SRP.GetDWORDValue &H80000002, "HARDWARE\DESCRIPTION\System\CentralProcessor\0", "~MHz", OC
					Set SRP = Nothing
				Else
					OC = CCS
				End If
				If OC Mod 2 = 1 Then OC = OC + 1
				FC = OC - MCS
				If FC > +10 Then OCLC = "��"
				If FC < -10 Then OCLC = "��"
				OCLC = OCLC & "Ƶ����:" & FormatPercent(FC / MCS, True, True)
				
				S.I = "��CPU ����:" & Trim(.Name)
				S.I = "��CPU �ܹ�:" & .Description
				S.I = "�����쳧��:" & .Manufacturer
				S.I = "����ڹ��:" & .SocketDesignation
				S.I = "��CPU ����:" & .CpuStatus & "	" & String(.CpuStatus, "��")
				S.I = "����������:" & .NumberOfCores & "	" & String(.NumberOfCores, "��")
				S.I = "���߳�����:" & .NumberOfLogicalProcessors & "	" & String(.NumberOfLogicalProcessors, "��")
				S.I = "����ַλ��:" & .AddressWidth & " Bit"
				S.I = "������λ��:" & .DataWidth  & " Bit"
				S.I = "��CPU ��ѹ:" & .CurrentVoltage / 10 & "V"
				S.I = "���ⲿƵ��:" & .ExtClock & " MHz"
				S.I = "����ǰƵ��:" & OC        & " MHz, " & OCLC
				S.I = "��ԭʼƵ��:" & MCS       & " MHz"
				S.I = "��CPUռ��%:" & .LoadPercentage & "%"
			End With
		Next
		S.I = "������������������������������"
		CPU = S
	End Function

	Function CacheMemory()
		On Error Resume Next
		S.I = "��[�����ڴ�]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_CacheMemory")
			With TempObj
				If .MaxCacheSize > 0 Then
					Select Case .Purpose
						Case "L1 Cache" AddStr = "(+DataBit)"
						Case Else
					End Select
					S.I = "������λ:" & .Purpose & " ID:" & .DeviceID & ":" & .MaxCacheSize & "KB" & AddStr
					AddStr = ""
				End If
			End With
		Next
		S.I = "������������������������������"
		CacheMemory = S
	End Function

	Function Memory()
		On Error Resume Next
		TempArr = Split("Unknown Other DRAM Synchronous-DRAM Cache-DRAM EDO EDRAM VRAM SRAM RAM ROM Flash EEPROM FEPROM EPROM CDRAM 3DRAM SDRAM SGRAM RDRAM DDR DDR-2")
		S.I = "��[�ڴ�]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_PhysicalMemory")
			With TempObj
				S.I = "������/��ǩ:" & .Name & "/" & .Caption
				S.I = "��BL    :" & .BankLabel
				S.I = "����    :" & .DeviceLocator
				S.I = "������   :" & .Capacity / 1048576 & "MB"
				S.I = "������   :" & TempArr(.MemoryType)
				S.I = "������   :" & .Speed & "MHz"
				S.I = "��������  :" & .Manufacturer
				S.I = "���Ȳ��  :" & IIf(.HotSwappable = True, True, False)
				S.I = "����λ��  :" & .TotalWidth
				S.I = "������λ�� :" & .DataWidth
				S.I = "��������� :" & .PartNumber
			End With
		Next
		S.I = "������������������������������"
		Memory = S
	End Function

	Function Video()
		On Error Resume Next
		TempArr1 = Split(" ���� δ֪ CGA EGA VGA SVGA MDA HGC MCGA 8514A XGA Linear Frame Buffer" & Space(160 - 14) & "PC-98")
		TempArr2 = Split(" ���� δ֪ ���� ����")
		S.I = "��[�Կ�]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_VideoController")
			With TempObj
				S.I = "�ǽӿ�   :" & TempArr1(.VideoArchitecture)
				S.I = "������   :" & .Name
				S.I = "����ǩ   :" & .Caption
				S.I = "��ID    :" & .DeviceID
				S.I = "��GPU   :" & .VideoProcessor
				S.I = "��������  :" & .AdapterCompatibility
				S.I = "�������Դ� :" & .AdapterRAM / 1048576 & "MB"
				S.I = "��ɨ��ģʽ :" & IIf(.CurrentScanMode = False, False, TempArr2(.CurrentScanMode))
				S.I = "���ֱ���  :" & .CurrentHorizontalResolution & " x " & .CurrentVerticalResolution
				S.I = "��ɫλ��  :" & .CurrentBitsPerPixel & "Bit"
				S.I = "��ˢ����  :" & .CurrentRefreshRate & "Hz" & "(" & .MinRefreshRate & "-" & .MaxRefreshRate& ")"
				S.I = "�������汾 :" & .DriverVersion
			End With
		Next
		S.I = "������������������������������"
		Video = S
	End Function

	Function Disk()
		On Error Resume Next
		S.I = "��[Ӳ��]"
		For Each TempObj In WMI.InstancesOf("Win32_DiskDrive")
			With TempObj
				S.I = "��[����:" & .Index & "]������������������������������������������������������������"
				S.I = "������  :" & .Name
				S.I = "����ǩ  :" & .Caption
				S.I = "���ӿ�  :" & .InterfaceType
				S.I = "�������� :" & .Manufacturer
				S.I = "�����  :" & .SerialNumber
				S.I = "����������:" & .Description & "	" & "����������:" & .MediaType
				S.I = "�������� :" & .TotalCylinders & " 	" & "����ͷ�� :" & .TotalHeads
				S.I = "����׼����:" & FormatNumber(.Size / 1000000000, 2, True) & "GB" & "	" & "��ʵ������:" & FormatNumber(.Size / 1073741824, 2, True) & "GB"
				S.I = "����������:" & .Partitions
				S.I = "�ǩ�������������������������������������������������������������������"
				S.I = "��[����]�ש������ש��������������ש����������������������ש�����������"
				S.I = "�� ����	��������������(GB)	����(��Сx����)		������"
				S.I = "�ǩ������贈�����贈�������������贈���������������������贈����������"
				For Each TempObj0 In WMI.InstancesOf("Win32_DiskPartition")
					If .Index = TempObj0.DiskIndex Then
						S.I = "�� " & TempObj0.Index & _
						"	��" & TempObj0.PrimaryPartition & _
						"	��" & FormatNumber(TempObj0.Size / 1073741824, 2, True) & "GB" & _
						"	��" & TempObj0.BlockSize & "x" & TempObj0.NumberOfBlocks & _
						" 	��" & _
						TIf(TempObj0.BootPartition, "����,") & _
						TIf(TempObj0.HiddenSectors, "����,") & _
						TIf(TempObj0.Bootable, "����.")
					End If
				Next
				S.I = "�ǩ������ߩ������ߩ��������������ߩ����������������������ߩ�����������"
				S.I = "��[����]��������������������������������������������������������������"
				S.I = "���ŵ�����:" & .SectorsPerTrack
				S.I = "��������С:" & .BytesPerSector
				S.I = "����������:" & .TotalSectors
				S.I = "����������������������������������������������������������������������"
			End With
		Next
		
		TempArr = Split("δ֪ ���ƶ����� ���ش��� ���������� ���� RAM����   ")
		S.I = "��[������Ϣ]����������������������������������������������������������"
		For Each TempObj1 In CreateObject("Scripting.FileSystemObject").Drives
			With TempObj1
				If .IsReady Then
					PTS = Int(.FreeSpace / .TotalSize * 100)
					S.I = "���̷�:" & .DriveLetter & " �ļ�ϵͳ:" & .FileSystem & "	����:" & TempArr(.DriveType) & "	���:" & .VolumeName
					S.I = "��" & "	������:" & PTS & "%	" & String((100 - PTS) / 5, "��") & String(PTS / 5, "��")
				Else
					S.I = "���̷�:" & .DriveLetter & "	����δ׼����!"
					S.I = "��" & "	������:0%	" & "�ԡԡԡԡԡԡԡԡԡԡԡԡԡԡԡԡԡԡԡ�"
				End If
			End With
		Next
		S.I = "����������������������������������������������������������������������"
		Disk = S
	End Function
	
	Function Sound()
		On Error Resume Next
		S.I = "��[����]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_SoundDevice")
			With TempObj
				S.I = "������/��ǩ:" & .Name & "/" & .Caption
				S.I = "��ID    :" & .DeviceID
				S.I = "��������  :" & .Manufacturer
			End With
		Next
		S.I = "������������������������������"
		Sound = S
	End Function
	
	Function NetWork()
		On Error Resume Next
		S.I = "��[����]"
		S.I = "������������������������������"
		For Each TempObj In WMI.ExecQuery("Select * from Win32_NetworkAdapter Where PhysicalAdapter = 'True'")
			With TempObj
				S.I = "��[����:" & Space(3 - Len(.Index)) & .Index & "]������������������"
				S.I = "����ǩ :" & .Caption
				S.I = "��PNPDID:" & .PNPDeviceID
				S.I = "��������:" & .Manufacturer
				S.I = "������ :" & IIf(TypeName(.Speed) = "Null", False, .Speed / 10000 & "bps")
				S.I = "������ :" & .NetEnabled
				S.I = "��������:" & .ServiceName
			End With
		Next
		S.I = "������������������������������"
		NetWork = S
	End Function
	
	Function Battery()
		On Error Resume Next
		TempArr1 = Split(" �ŵ� ������ ���� �� �ٽ� ��� ���>�� ���>�� ���>�ٽ� δ���� ���ֳ��")
		TempArr2 = Split(" ���� δ֪ Ǧ�� ���� �������⻯�� ����� п���� ﮾ۺ���")
		S.I = "��[�ڲ����]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_Battery")
			With TempObj
				S.I = "������/��ǩ:" & .Name & "/" & .Caption
				S.I = "��ID    :" & .DeviceID
				S.I = "��PNPDID  :" & .PNPDeviceID
				S.I = "�����ʱ�� :" & .BatteryRechargeTime
				S.I = "��״̬   :" & TempArr1(.BatteryStatus)
				S.I = "������   :" & TempArr2(.Chemistry)
			End With
		Next
		S.I = "������������������������������"
		Battery = S
	End Function
	
	Function PortableBattery()
		On Error Resume Next
		TempArr1 = Split(" ���� δ֪ ���� �� �ٽ� ��� ���>�� ���>�� ���>�ٽ� δ���� ���ֳ��")
		TempArr2 = Split(" ���� δ֪ Ǧ�� ���� �������⻯�� ����� п���� ﮾ۺ���")
		S.I = "��[��Я���]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_PortableBattery")
			With TempObj
				S.I = "������/��ǩ:" & .Name & "/" & .Caption
				S.I = "��ID    :" & .DeviceID
				S.I = "��PNPDID  :" & .PNPDeviceID
				S.I = "��������  :" & .Manufacturer
				S.I = "��Ԥ��ʣ�� :" & .EstimatedChargeRemaining
				S.I = "��Ԥ��ʱ�� :" & .EstimatedRunTime
				S.I = "����Դ���� :" & .PowerManagementSupported
				S.I = "��λ��   :" & .Location
				S.I = "�����ܵ�� :" & .SmartBatteryVersion
				S.I = "������   :" & TempArr2(.Chemistry)
			End With
		Next
		S.I = "������������������������������"
		PortableBattery = S
	End Function
	
	Function USB()
		On Error Resume Next
		S.I = "��[USB��]"
		S.I = "������������������������������"
		For Each TempObj In WMI.InstancesOf("Win32_USBController")
			With TempObj
				S.I = "�Ǳ�ǩ :" & .Caption
				S.I = "��ID  :" & .DeviceID
				S.I = "��PNPDID:" & .PNPDeviceID
				S.I = "��������:" & .Manufacturer
			End With
		Next
		S.I = "������������������������������"
		USB = S
	End Function
End Class


'----

	'���
	Sub Print(ByVal Texts)
		WScript.StdOut.Write Texts
	End Sub
	Sub Echo(ByVal GEOM_TempData)
		WScript.Echo GEOM_TempData
	End Sub

	'���:������,�հ׳���
	Sub PrintC(ByVal Texts, ByVal LenNum)
		WScript.StdOut.Write Chr(13) & Texts & String(LenNum, " ")
	End Sub
	
	'���,+����
	Sub PrintL(ByVal Texts)
		WScript.StdOut.WriteLine(Texts)
	End Sub
	
	'����
	Function InPut()
		InPut = WScript.StdIn.ReadLine
	End Function

Function IIf(ByVal GEOM_tf, ByVal GEOM_T, ByVal GEOM_F)
	If GEOM_tf = True Then IIF = GEOM_T Else IIF = GEOM_F
End Function

'iif��
Function TIf(ByVal GEOM_tf, ByVal GEOM_T)
	If GEOM_tf = True Then TIF = GEOM_T
End Function

'iif��
Function FIf(ByVal GEOM_tf, ByVal GEOM_F)
	If GEOM_tf = False Then FIF = GEOM_F
End Function

