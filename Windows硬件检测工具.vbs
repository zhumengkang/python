Const MyName = "Windows硬件检视工具(康康版) --by:Rex.Pack(康康专用)"

If Not LCase(Replace(WScript.FullName, WScript.Path & "\", "")) = "cscript.exe" Then
	Set WS = CreateObject("WScript.Shell")
	WS.Run "CMD /c mode con: cols=115 & Color 0A & Title " & MyName & " & CScript //nologo """ & WScript.ScriptFullName & """"
	WScript.Quit
End If
'----初始化
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
	Echo "[设备列表]"
	Echo " 常用组 A: 1.OS	2.CPU	3.主板	4.内存	5.显卡	6.硬盘"
	Echo " 次级组 B: 7.USB	8.缓存	9.网卡"
	Echo " 酱油组 C: 10.BIOS	11.声卡	电池(12.内部 13.便携)"
	Echo "[测试CPU]"
	Echo " 测试组 D: 14.变量幂次方运算	15.字符叠合	16.加法计算	17.叠加计算"
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
			Echo "#不支持的命令"
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
		If Left(Str, 1) = "☆" Then Str = Str & String(80, "=")
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
		S1 = "变量幂次方运算 " & DPS & "万次用时:" & RT("TestVar = I ^ 2", DPS * 10000)
	End Function
	
	Function S2()
		S2 = "字符叠合 " & DPS & "000次用时:" & RT("TestVar = TestVar & vbTab", DPS * 1000)
	End Function
	
	Function S3()
		S3 = "加法计算 " & DPS & "万次用时:" & RT("TestVar = 86 + 32", DPS * 10000)
	End Function
	
	Function S4()
		S4 = "叠加计算 " & DPS & "万次用时:" & RT("TestVar = TestVar + I", DPS * 10000)
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
		S.I = "☆[BIOS]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_BIOS")
			With TempObj
				S.I = "┣厂商		:" & .Manufacturer
				S.I = "┇日期		:" & .ReleaseDate
				S.I = "┇OEM 版本	:" & .Version
				S.I = "┇BIOS 版本	:" & .SMBIOSBIOSVersion
				S.I = "┇Major版本	:" & .SMBIOSMajorVersion
				S.I = "┇状态		:" & .Status
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		BIOS = S
	End Function

	Function OS()
		On Error Resume Next
		S.I = "☆[操作系统]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj in WMI.InstancesOf("Win32_OperatingSystem")
			With TempObj
				S.I = "┣标签  :" & .Caption
				S.I = "┇CSDV  :" & .CSDVersion
				S.I = "┇版本  :" & .Version
				S.I = "┇RAM识别:" & .TotalVisibleMemorySize / 1024 & "MB"
				S.I = "┇RAM可用:" & .FreePhysicalMemory / 1024 & "MB"
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		OS = S
	End Function
	
	Function Board()
		On Error Resume Next
		S.I = "☆[主板]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_BaseBoard")
			With TempObj
				S.I = "┣标签:" & .Caption
				S.I = "┇编号:" & .Product
				S.I = "┇序号:" & .SerialNumber 
				S.I = "┇名称:" & .Name
				S.I = "┇版本:" & .Version
				S.I = "┇厂商:" & .Manufacturer
				S.I = "┇状态:" & .Status
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		Board = S
	End Function
	
	Function CPU()
		On Error Resume Next
		S.I = "☆[CPU]"
		S.I = "┏━━━━━━━━━━━━━┉"
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
				If FC > +10 Then OCLC = "超"
				If FC < -10 Then OCLC = "降"
				OCLC = OCLC & "频比率:" & FormatPercent(FC / MCS, True, True)
				
				S.I = "┣CPU 名称:" & Trim(.Name)
				S.I = "┇CPU 架构:" & .Description
				S.I = "┇制造厂商:" & .Manufacturer
				S.I = "┇插口规格:" & .SocketDesignation
				S.I = "┇CPU 数量:" & .CpuStatus & "	" & String(.CpuStatus, "※")
				S.I = "┇核心数量:" & .NumberOfCores & "	" & String(.NumberOfCores, "∷")
				S.I = "┇线程数量:" & .NumberOfLogicalProcessors & "	" & String(.NumberOfLogicalProcessors, "≈")
				S.I = "┇地址位宽:" & .AddressWidth & " Bit"
				S.I = "┇数据位宽:" & .DataWidth  & " Bit"
				S.I = "┇CPU 电压:" & .CurrentVoltage / 10 & "V"
				S.I = "┇外部频率:" & .ExtClock & " MHz"
				S.I = "┇当前频率:" & OC        & " MHz, " & OCLC
				S.I = "┇原始频率:" & MCS       & " MHz"
				S.I = "┇CPU占用%:" & .LoadPercentage & "%"
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		CPU = S
	End Function

	Function CacheMemory()
		On Error Resume Next
		S.I = "☆[缓存内存]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_CacheMemory")
			With TempObj
				If .MaxCacheSize > 0 Then
					Select Case .Purpose
						Case "L1 Cache" AddStr = "(+DataBit)"
						Case Else
					End Select
					S.I = "┇作用位:" & .Purpose & " ID:" & .DeviceID & ":" & .MaxCacheSize & "KB" & AddStr
					AddStr = ""
				End If
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		CacheMemory = S
	End Function

	Function Memory()
		On Error Resume Next
		TempArr = Split("Unknown Other DRAM Synchronous-DRAM Cache-DRAM EDO EDRAM VRAM SRAM RAM ROM Flash EEPROM FEPROM EPROM CDRAM 3DRAM SDRAM SGRAM RDRAM DDR DDR-2")
		S.I = "☆[内存]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_PhysicalMemory")
			With TempObj
				S.I = "┣名称/标签:" & .Name & "/" & .Caption
				S.I = "┇BL    :" & .BankLabel
				S.I = "┇槽    :" & .DeviceLocator
				S.I = "┇容量   :" & .Capacity / 1048576 & "MB"
				S.I = "┇类型   :" & TempArr(.MemoryType)
				S.I = "┇速率   :" & .Speed & "MHz"
				S.I = "┇制造商  :" & .Manufacturer
				S.I = "┇热插拔  :" & IIf(.HotSwappable = True, True, False)
				S.I = "┇总位宽  :" & .TotalWidth
				S.I = "┇数据位宽 :" & .DataWidth
				S.I = "┇部分序号 :" & .PartNumber
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		Memory = S
	End Function

	Function Video()
		On Error Resume Next
		TempArr1 = Split(" 其他 未知 CGA EGA VGA SVGA MDA HGC MCGA 8514A XGA Linear Frame Buffer" & Space(160 - 14) & "PC-98")
		TempArr2 = Split(" 其他 未知 隔行 逐行")
		S.I = "☆[显卡]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_VideoController")
			With TempObj
				S.I = "┣接口   :" & TempArr1(.VideoArchitecture)
				S.I = "┇名称   :" & .Name
				S.I = "┇标签   :" & .Caption
				S.I = "┇ID    :" & .DeviceID
				S.I = "┇GPU   :" & .VideoProcessor
				S.I = "┇制造商  :" & .AdapterCompatibility
				S.I = "┇物理显存 :" & .AdapterRAM / 1048576 & "MB"
				S.I = "┇扫描模式 :" & IIf(.CurrentScanMode = False, False, TempArr2(.CurrentScanMode))
				S.I = "┇分辨率  :" & .CurrentHorizontalResolution & " x " & .CurrentVerticalResolution
				S.I = "┇色位盘  :" & .CurrentBitsPerPixel & "Bit"
				S.I = "┇刷新率  :" & .CurrentRefreshRate & "Hz" & "(" & .MinRefreshRate & "-" & .MaxRefreshRate& ")"
				S.I = "┇驱动版本 :" & .DriverVersion
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		Video = S
	End Function

	Function Disk()
		On Error Resume Next
		S.I = "☆[硬盘]"
		For Each TempObj In WMI.InstancesOf("Win32_DiskDrive")
			With TempObj
				S.I = "┏[磁盘:" & .Index & "]━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
				S.I = "┇名称  :" & .Name
				S.I = "┇标签  :" & .Caption
				S.I = "┇接口  :" & .InterfaceType
				S.I = "┇制造商 :" & .Manufacturer
				S.I = "┇序号  :" & .SerialNumber
				S.I = "┇介质描述:" & .Description & "	" & "┇介质类型:" & .MediaType
				S.I = "┇柱面数 :" & .TotalCylinders & " 	" & "┇磁头数 :" & .TotalHeads
				S.I = "┇标准容量:" & FormatNumber(.Size / 1000000000, 2, True) & "GB" & "	" & "┇实际容量:" & FormatNumber(.Size / 1073741824, 2, True) & "GB"
				S.I = "┇分区数量:" & .Partitions
				S.I = "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
				S.I = "┣[分区]┳━━━┳━━━━━━━┳━━━━━━━━━━━┳━━━━━┉"
				S.I = "┇ 索引	┇主分区┇容量(GB)	┇块(大小x数量)		┇属性"
				S.I = "┣━━━╋━━━╋━━━━━━━╋━━━━━━━━━━━╋━━━━━┉"
				For Each TempObj0 In WMI.InstancesOf("Win32_DiskPartition")
					If .Index = TempObj0.DiskIndex Then
						S.I = "┇ " & TempObj0.Index & _
						"	┇" & TempObj0.PrimaryPartition & _
						"	┇" & FormatNumber(TempObj0.Size / 1073741824, 2, True) & "GB" & _
						"	┇" & TempObj0.BlockSize & "x" & TempObj0.NumberOfBlocks & _
						" 	┇" & _
						TIf(TempObj0.BootPartition, "引导,") & _
						TIf(TempObj0.HiddenSectors, "隐藏,") & _
						TIf(TempObj0.Bootable, "启动.")
					End If
				Next
				S.I = "┣━━━┻━━━┻━━━━━━━┻━━━━━━━━━━━┻━━━━━┉"
				S.I = "┣[扇区]━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
				S.I = "┇磁道扇区:" & .SectorsPerTrack
				S.I = "┇扇区大小:" & .BytesPerSector
				S.I = "┇总扇区数:" & .TotalSectors
				S.I = "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
			End With
		Next
		
		TempArr = Split("未知 可移动磁盘 本地磁盘 网络驱动器 光盘 RAM磁盘   ")
		S.I = "┏[分区信息]━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
		For Each TempObj1 In CreateObject("Scripting.FileSystemObject").Drives
			With TempObj1
				If .IsReady Then
					PTS = Int(.FreeSpace / .TotalSize * 100)
					S.I = "┇盘符:" & .DriveLetter & " 文件系统:" & .FileSystem & "	类型:" & TempArr(.DriveType) & "	卷标:" & .VolumeName
					S.I = "┇" & "	空闲率:" & PTS & "%	" & String((100 - PTS) / 5, "■") & String(PTS / 5, "□")
				Else
					S.I = "┇盘符:" & .DriveLetter & "	磁盘未准备好!"
					S.I = "┇" & "	空闲率:0%	" & "≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡"
				End If
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┉"
		Disk = S
	End Function
	
	Function Sound()
		On Error Resume Next
		S.I = "☆[声卡]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_SoundDevice")
			With TempObj
				S.I = "┣名称/标签:" & .Name & "/" & .Caption
				S.I = "┇ID    :" & .DeviceID
				S.I = "┇制造商  :" & .Manufacturer
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		Sound = S
	End Function
	
	Function NetWork()
		On Error Resume Next
		S.I = "☆[网卡]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.ExecQuery("Select * from Win32_NetworkAdapter Where PhysicalAdapter = 'True'")
			With TempObj
				S.I = "┣[网卡:" & Space(3 - Len(.Index)) & .Index & "]━━━━━━━━┉"
				S.I = "┇标签 :" & .Caption
				S.I = "┇PNPDID:" & .PNPDeviceID
				S.I = "┇制造商:" & .Manufacturer
				S.I = "┇速率 :" & IIf(TypeName(.Speed) = "Null", False, .Speed / 10000 & "bps")
				S.I = "┇启用 :" & .NetEnabled
				S.I = "┇服务名:" & .ServiceName
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		NetWork = S
	End Function
	
	Function Battery()
		On Error Resume Next
		TempArr1 = Split(" 放电 交流电 充满 低 临界 充电 充电>高 充电>低 充电>临界 未定义 部分充电")
		TempArr2 = Split(" 其他 未知 铅酸 镉镍 镍金属氢化物 锂离子 锌空气 锂聚合物")
		S.I = "☆[内部电池]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_Battery")
			With TempObj
				S.I = "┣名称/标签:" & .Name & "/" & .Caption
				S.I = "┇ID    :" & .DeviceID
				S.I = "┇PNPDID  :" & .PNPDeviceID
				S.I = "┇充电时间 :" & .BatteryRechargeTime
				S.I = "┇状态   :" & TempArr1(.BatteryStatus)
				S.I = "┇材料   :" & TempArr2(.Chemistry)
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		Battery = S
	End Function
	
	Function PortableBattery()
		On Error Resume Next
		TempArr1 = Split(" 其他 未知 充满 低 临界 充电 充电>高 充电>低 充电>临界 未定义 部分充电")
		TempArr2 = Split(" 其他 未知 铅酸 镉镍 镍金属氢化物 锂离子 锌空气 锂聚合物")
		S.I = "☆[便携电池]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_PortableBattery")
			With TempObj
				S.I = "┣名称/标签:" & .Name & "/" & .Caption
				S.I = "┇ID    :" & .DeviceID
				S.I = "┇PNPDID  :" & .PNPDeviceID
				S.I = "┇制造商  :" & .Manufacturer
				S.I = "┇预计剩余 :" & .EstimatedChargeRemaining
				S.I = "┇预计时间 :" & .EstimatedRunTime
				S.I = "┇电源管理 :" & .PowerManagementSupported
				S.I = "┇位置   :" & .Location
				S.I = "┇智能电池 :" & .SmartBatteryVersion
				S.I = "┇材料   :" & TempArr2(.Chemistry)
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		PortableBattery = S
	End Function
	
	Function USB()
		On Error Resume Next
		S.I = "☆[USB坞]"
		S.I = "┏━━━━━━━━━━━━━┉"
		For Each TempObj In WMI.InstancesOf("Win32_USBController")
			With TempObj
				S.I = "┣标签 :" & .Caption
				S.I = "┇ID  :" & .DeviceID
				S.I = "┇PNPDID:" & .PNPDeviceID
				S.I = "┇制造商:" & .Manufacturer
			End With
		Next
		S.I = "┗━━━━━━━━━━━━━┉"
		USB = S
	End Function
End Class


'----

	'输出
	Sub Print(ByVal Texts)
		WScript.StdOut.Write Texts
	End Sub
	Sub Echo(ByVal GEOM_TempData)
		WScript.Echo GEOM_TempData
	End Sub

	'输出:覆盖行,空白长度
	Sub PrintC(ByVal Texts, ByVal LenNum)
		WScript.StdOut.Write Chr(13) & Texts & String(LenNum, " ")
	End Sub
	
	'输出,+换行
	Sub PrintL(ByVal Texts)
		WScript.StdOut.WriteLine(Texts)
	End Sub
	
	'输入
	Function InPut()
		InPut = WScript.StdIn.ReadLine
	End Function

Function IIf(ByVal GEOM_tf, ByVal GEOM_T, ByVal GEOM_F)
	If GEOM_tf = True Then IIF = GEOM_T Else IIF = GEOM_F
End Function

'iif真
Function TIf(ByVal GEOM_tf, ByVal GEOM_T)
	If GEOM_tf = True Then TIF = GEOM_T
End Function

'iif假
Function FIf(ByVal GEOM_tf, ByVal GEOM_F)
	If GEOM_tf = False Then FIF = GEOM_F
End Function

