Option Explicit
Dim wsh, choice, cmd
Set wsh = CreateObject("WScript.Shell")

choice = InputBox( _
    "极域屏蔽器任务管理" & vbCrLf & vbCrLf & _
    "1 = 添加开机自启任务" & vbCrLf & _
    "2 = 删除开机自启任务" & vbCrLf & _
    "0 = 退出", _
    "任务计划管理")

If choice = "1" Then
    cmd = "schtasks /create /tn JiyuBlocker /tr ""D:\屏蔽器.vbs"" /sc onlogon /rl highest /f"
    wsh.Run cmd, 0, True
    MsgBox "已添加任务：JiyuBlocker（开机自动运行 D:\屏蔽器.vbs）", 64, "完成"

ElseIf choice = "2" Then
    cmd = "schtasks /delete /tn JiyuBlocker /f"
    wsh.Run cmd, 0, True
    MsgBox "已删除任务：JiyuBlocker（开机不再运行屏蔽器）", 64, "完成"

Else
    WScript.Quit
End If
