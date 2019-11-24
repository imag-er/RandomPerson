VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PersonPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Private Type NoteBall
        X As Long
        y As Long
        XDir As Long
        YDir As Long
        alpha As Single
    End Type
    Dim Balls() As NoteBall
'======================================
Public Sub CreateBalls(index As Integer)
    Dim WCount As Long, HCount As Long, MaxW As Long, MaxH As Long
    WCount = Int(RGW / (400 + 50))
    HCount = Int(RGH / (220 + 50))
    MaxH = Int(UBound(Person) / WCount) + 1
    
    For I = 0 To UBound(Person)
        MaxW = IIf(UBound(Person) + 1 > WCount, IIf(Int(I / WCount) < Int(UBound(Person) / WCount), WCount, (UBound(Person) Mod WCount) + 1), UBound(Person) + 1)
        BoxX = RGW / 2 - MaxW * 450 / 2 + (I Mod WCount) * (400 + 50) + 200 + 50
        BoxY = RGH / 2 - MaxH * 270 / 2 + Int(I / WCount) * (220 + 50) + 110 + 50
        For j = 1 To 4
            ReDim Preserve Balls(UBound(Balls) + 1)
            With Balls(UBound(Balls))
                .X = BoxX - 48 * 3 / 2 + 48 * index
                .y = BoxY
                .alpha = 1
                .XDir = (Int(Rnd * 10) + 5) * IIf(Int(Rnd * 2) = 1, 1, -1)
                .YDir = (Int(Rnd * 10) + 5) * IIf(Int(Rnd * 2) = 1, 1, -1)
            End With
        Next
    Next
End Sub
Public Sub Update()
    '��Ϸÿһ֡�Ĺ��̣����ƹ�������ڴ˴���
    
    Page.Clear argb(200, 0, 0, 0) '��ջ���
    'argb(255, 0, 0, 0)
    
    If Clicked Then
        If GetTickCount - ClickTime >= 2000 Then
            Call DoneRandom
            Clicked = False
        End If
    End If
    
    Dim pro As Single, tpro As Single, BoxX As Long, BoxY As Long
    Dim Name As String, j As Integer
    
    pro = (GetTickCount - RandomTime) / 5000
    
    If pro > 1 Then
        pro = 1
        If RandomDone = False Then
            RandomDone = True: Call DoneRandom
        End If
    End If
    
    Dim WCount As Long, HCount As Long, MaxW As Long, MaxH As Long
    WCount = Int(RGW / (400 + 50))
    HCount = Int(RGH / (220 + 50))
    MaxH = Int(UBound(Person) / WCount) + 1
    
    For I = 0 To UBound(Person)
        MaxW = IIf(UBound(Person) + 1 > WCount, IIf(Int(I / WCount) < Int(UBound(Person) / WCount), WCount, (UBound(Person) Mod WCount) + 1), UBound(Person) + 1)
        BoxX = RGW / 2 - MaxW * 450 / 2 + (I Mod WCount) * (400 + 50) + 200 + 50
        BoxY = RGH / 2 - MaxH * 270 / 2 + Int(I / WCount) * (220 + 50) + 110 + 50
        Select Case pro
            Case Is <= 0.2
                Page.Writes Int(Rnd * 61 + 1), BoxX, BoxY - 40, 64, argb(255, 255, 255, 255), align:=StringAlignmentCenter
            Case Else
                tpro = (pro - 0.2) / 0.2
                If tpro <= 0 Then tpro = 0
                If tpro > 1 Then tpro = 1
                tpro = Cubic(tpro, 0, 1, 1, 1)
                
                Page.Paint 0, BoxX, BoxY, 400, 220, argb(255 * tpro, 255, 255, 255), pos:=posOnCenter
                Page.Paint 0, BoxX - 200, BoxY - 110, 400 * tpro, 60, IIf(Student(3, Person(I)) = "��", argb(tpro * 255, 1, 208, 214), argb(tpro * 255, 251, 75, 38)), 3

                Page.Writes Student(1, Person(I)), BoxX - 100 * tpro, BoxY - 40 - 61 * tpro, 64 - 35 * tpro, argb(255, 255 - (255 - 255) * tpro, 255 - (255 - 255) * tpro, 255 - (255 - 255) * tpro), align:=StringAlignmentCenter
                Page.Writes "No.", BoxX - 180, BoxY - 40 - 61, 64 - 35, argb(150 * tpro, 255, 255, 255), align:=StringAlignmentNear
                    
                tpro = (pro - 0.4) / 0.2
                If tpro <= 0 Then tpro = 0
                If tpro > 1 Then tpro = 1
                tpro = Cubic(tpro, 0, 1, 1, 1)
                
                Name = ""
                
                For j = 1 To 3
                    If tpro >= j * 0.3 Then
                        Name = Name & Mid(Student(0, Person(I)), j, 1)
                        If Not Beeps(j) Then
                            Piano.Play 7 + j * 2
                            Call CreateBalls(j)
                            Beeps(j) = True
                        End If
                    Else
                        Name = Name & "��"
                    End If
                Next
    
                If tpro > 0 Then Page.Writes Name & IIf(pro >= 0.7, IIf(Student(3, Person(I)) = "��", " ��", " ��"), ""), BoxX, BoxY - 27, 48, argb(255, 0, 0, 0), align:=StringAlignmentCenter
        
                tpro = (pro - 0.6) / 0.2
                If tpro <= 0 Then tpro = 0
                If tpro > 1 Then tpro = 1
                tpro = Cubic(tpro, 0, 1, 1, 1)
                
                If tpro > 0 And pro <= 0.8 Then Page.Writes "�ۼƱ�����" & RCount(Person(I) + 1) & "��", BoxX, BoxY + 53, 24, argb(255 * tpro, 128, 128, 128), align:=StringAlignmentCenter
                
                tpro = (pro - 0.8) / 0.2
                If tpro <= 0 Then tpro = 0
                If tpro > 1 Then tpro = 1
                tpro = Cubic(tpro, 0, 1, 1, 1)
                
                If tpro > 0 And pro <= 1 Then Page.Writes "�ۼƱ�����" & RCount(Person(I) + 1) & "��", BoxX, BoxY + 53, 24, argb(255 - 255 * tpro, 128, 128, 128), align:=StringAlignmentCenter
                Page.Paint 0, BoxX + 30 - 140, BoxY + 73, 280, 10, argb(255 * tpro, 180, 180, 180)
                Dim Exp As Long
                Exp = RCount(Person(I) + 1) Mod 5
                If Exp = 0 And pro < 1 Then Exp = 5
                
                Page.Paint 0, BoxX + 30 - 140, BoxY + 73, (Exp - 1 * (1 - tpro)) / 5 * 280, 10, argb(255 * tpro, 9, 241, 117)
                Page.Writes "Lv." & Int(RCount(Person(I) + 1) / 5) - IIf(Exp = 5, 1, 0), BoxX + 10 - 190, BoxY + 60, 24, IIf(Exp = 0, IIf(Student(3, Person(I)) = "��", argb(255, 1, 208, 214), argb(255, 251, 75, 38)), argb(255 * tpro, 1, 1, 1))
                If Exp = 0 Then
                    Page.Writes "������", BoxX + 300 - 192, BoxY - 99, 24, argb(255, 255, 255, 255), style:=FontStyleBold
                End If
                
        End Select
    Next
    
    For I = 1 To UBound(Balls)
        If I > UBound(Balls) Then Exit For
NextBall:
        Balls(I).X = Balls(I).X + Balls(I).XDir
        Balls(I).y = Balls(I).y + Balls(I).YDir
        Balls(I).XDir = Balls(I).XDir * 1.1
        Balls(I).YDir = Balls(I).YDir * 1.1
        Balls(I).alpha = Balls(I).alpha - 0.03
        Page.DrawImage "note.png", Balls(I).X, Balls(I).y, alpha:=Balls(I).alpha, pos:=posOnCenter
        If Balls(I).X < 0 Or Balls(I).y < 0 Or Balls(I).X > RGW Or Balls(I).y > RGH Then
            Balls(I) = Balls(UBound(Balls))
            ReDim Preserve Balls(UBound(Balls) - 1)
            I = I - 1
            GoTo NextBall
        End If
    Next
    
    If Mouse.state = 2 Then ECore.NewTransform , , "MainPage"
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
    Page.Res.NewImages App.path & "\assets"
    '����ҳ��
    ECore.Add Page, "PersonPage"
    ReDim Balls(0)
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub