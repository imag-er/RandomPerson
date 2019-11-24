VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ReportPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
'======================================

Public Sub Update()
    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear argb(255, 0, 0, 0) '��ջ���

    '================================================================
    '   ʾ������������
    '   Page.Writes "��������", 20,20, Color:=argb(255, 0, 0, 0)
    '================================================================
    
    Page.Writes "ҡ��ͳ��", RGW / 2, 70, 48, argb(255, 255, 255, 255), align:=StringAlignmentCenter
    Page.Writes "���Թ�ƽ����", RGW / 2, 140, 28, argb(150, 255, 255, 255), align:=StringAlignmentCenter
    
    Dim pro As Single

    pro = (GetTickCount - ReportTime) / 2000
    pro = Cubic(pro, 0, 1, 1, 1)
    
    If pro > 1 Then
        pro = 1
    End If
    
    Dim Max As Single, Pitch As Single
    For I = 1 To 62
        If RCount(I) > Max Then Max = RCount(I)
        Pitch = (Pitch + RCount(I)) / 2
    Next
    
    Dim W As Long
    W = Int(RGW / 62)
    Pitch = Pitch * pro
    
    For I = 1 To 62
        Page.Paint 0, W * (I - 1), RGH - 200, W + 1, RCount(I) * pro / Max * (RGH / 2), argb(RCount(I) * pro / Max * 255, 51, 203, 186), pos:=posOnBottom
        Page.Writes Student(0, I - 1), W * (I - 1), RGH - 200, 24, argb(RCount(I) * pro / Max * 255, 255, 255, 255), W + 1, 200, StringAlignmentCenter, FontStyleBold
        Page.Writes Int(RCount(I) * pro), W * (I - 1), RGH - 200 - RCount(I) / Max * (RGH / 2) * pro - 30, 16, argb(255, 255, 255, 255), W + 1, 30, align:=StringAlignmentCenter, style:=FontStyleBold
    Next
    Page.Paint 0, 0, RGH - 200 - Pitch / Max * (RGH / 2), RGW + 1, 10, argb(100, 255, 255, 255)
    Page.Writes "ƽ��" & Int(Pitch) & "��", RGW / 2, RGH - 200 - Pitch / Max * (RGH / 2) + 10, 24, argb(255, 255, 255, 255), align:=StringAlignmentCenter
    
    If Mouse.state = 2 Then ECore.NewTransform , , "MainPage"
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub AnimationMsg(id As String, msg As String)
    '������Ϣ����
End Sub
Public Sub Enter()
    'ҳ������¼�
    ReportTime = GetTickCount
End Sub
Public Sub Leave()
    'ҳ���뿪�¼�
End Sub
Public Sub Gotfocus()
    '����ȡ�ý����¼�
End Sub
Public Sub Lostfocus()
    '����ʧȥ�����¼�
End Sub
Public Sub AnimationDone(id As Integer)
    '�������Ž����¼�
    'id�������Ķ���ID
End Sub
Private Sub Class_Initialize()
    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.NewImages App.path & "\assets"
    '����ҳ��
    ECore.Add Page, "ReportPage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub