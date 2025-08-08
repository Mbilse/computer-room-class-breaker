Option Explicit
Dim wsh, choice
Set wsh = CreateObject("WScript.Shell")

choice = InputBox( _
    "极域电子教室屏蔽工具 (隐身版)" & vbCrLf & vbCrLf & _
    "1 = 屏蔽极域控制" & vbCrLf & _
    "2 = 恢复正常使用" & vbCrLf & _
    "0 = 退出", _
    "极域屏蔽工具")

If choice = "1" Then
    ' 结束进程
    wsh.Run "taskkill /f /im StudentMain.exe", 0, True
    wsh.Run "taskkill /f /im Student.exe", 0, True
    wsh.Run "taskkill /f /im GStudent.exe", 0, True
    wsh.Run "taskkill /f /im studentmain.exe", 0, True

    ' 添加防火墙规则
    wsh.Run "netsh advfirewall firewall add rule name=""Block Jiyu TCP"" dir=out protocol=TCP localport=4705 action=block", 0, True
    wsh.Run "netsh advfirewall firewall add rule name=""Block Jiyu UDP"" dir=out protocol=UDP localport=4706 action=block", 0, True
    wsh.Run "netsh advfirewall firewall add rule name=""Block Jiyu TCP in"" dir=in protocol=TCP localport=4705 action=block", 0, True
    wsh.Run "netsh advfirewall firewall add rule name=""Block Jiyu UDP in"" dir=in protocol=UDP localport=4706 action=block", 0, True

    MsgBox "屏蔽完成！", 64, "极域屏蔽工具"

ElseIf choice = "2" Then
    ' 删除防火墙规则
    wsh.Run "netsh advfirewall firewall delete rule name=""Block Jiyu TCP""", 0, True
    wsh.Run "netsh advfirewall firewall delete rule name=""Block Jiyu UDP""", 0, True
    wsh.Run "netsh advfirewall firewall delete rule name=""Block Jiyu TCP in""", 0, True
    wsh.Run "netsh advfirewall firewall delete rule name=""Block Jiyu UDP in""", 0, True

    MsgBox "恢复完成！", 64, "极域屏蔽工具"

Else
    ' 退出
    WScript.Quit
End If