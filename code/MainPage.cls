VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "MainPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Dim Clicked As Boolean, ClickTime As Long
    Dim Beeps(3) As Boolean
    Dim Touched As Boolean
'======================================

Public Sub Update()
    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear 0 '��ջ���

    Page.DrawImage "ui.png", RGW / 2, RGH / 2, alpha:=1, pos:=posOnCenter
    '================================================================
    '   ʾ������������
    '   Page.Writes "��������", 20,20, Color:=argb(255, 0, 0, 0)
    '================================================================
    Page.Writes "��һ���ר��ҡ�Ż�", RGW / 2 - 100 + 2, 60, 18, argb(100, 0, 0, 0)
    If Index <> -1 Then
        Page.Writes "���� " & Student(1, RIndex), RGW / 2 - 100, RGH / 2 - 48 * 2.5 + 75, 24, argb(150, 0, 0, 0)
        If Clicked Then
            Dim Name As String, j As Integer
            If GetTickCount - ClickTime <= 1000 Then
                Name = "������"
            Else
                For j = 1 To 3
                    If GetTickCount - ClickTime >= 1000 + j * 333 Then
                        Name = Name & Mid(Student(0, RIndex), j, 1)
                        If Not Beeps(j) Then Beeps(j) = True: win32api.Beep 800 + j * 400, 200
                    Else
                        Name = Name & "��"
                    End If
                Next
            End If
            Page.Writes "����С���� " & Name, RGW / 2 - 100 - 3, RGH / 2 - 48 * 1.8 + 75, 36, argb(255, 32, 32, 32)
        Else
            Page.Writes "����С���� " & Student(0, RIndex), RGW / 2 - 100 - 3, RGH / 2 - 48 * 1.8 + 75, 36, argb(255, 32, 32, 32)
        End If
    End If
    
    If Clicked Then
        If GetTickCount - ClickTime <= 1000 Then Call GetRandom
        If GetTickCount - ClickTime >= 2000 Then
            Call DoneRandom
            Clicked = False
        End If
    End If
    
    Page.DrawImage "close.png", RGW / 2, RGH - 40, alpha:=1, pos:=posOnCenter
    If CheckMouse2 = mMouseUp Then GameWindow.WindowState = 1
    
    If CheckMouse(0, 0, GW, GH) = mMouseUp Then
        Erase Beeps
        Call StartRandom
        ClickTime = GetTickCount: Clicked = True
    End If
    
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub AnimationMsg(ID As String, msg As String)
    '������Ϣ����
End Sub
Public Sub Enter()
    'ҳ������¼�
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
Public Sub AnimationDone(ID As Integer)
    '�������Ž����¼�
    'id�������Ķ���ID
End Sub
Private Sub Class_Initialize()
    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.NewImages App.path & "\assets", 0.65
    '����ҳ��
    ECore.Add Page, "MainPage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub