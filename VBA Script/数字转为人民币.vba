'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'ԭ����: https://blog.csdn.net/qilei2010/article/details/85253970
'С���������޸�
'�÷�: ѡ�����ֺ�ִ�б��ű�����''

Sub ת���������()

'����ѡ����תΪ����Ҵ�д
    Dim rmb As String
    rmb = mychange(Selection.Text)
    
    Selection.Text = rmb

End Sub

Function mychange(ByVal Myinput)
    'MyinputA ȥ���հ׷��ұ��������ȥ��С����������ִ�
    'MyinputB ��ת������ִ�
    'MyinputC ת��Ϊ��д�Ľ��
    Dim Temp, TempA, MyinputA, MyinputB, MyinputC
    Dim Place As String
    Dim J As Integer
    Place = "�ֽ�Ԫʰ��Ǫ��ʰ��Ǫ��ʰ��Ǫ��"
    shuzi1 = "Ҽ��������½��ƾ�"
    shuzi2 = "����Ԫ������������������������"
    
    qianzhui = ""
    If Val(Myinput) = 0 Then Myinput = 0
    If Myinput = "" Then Myinput = 0
    If Myinput < 0 Then qianzhui = "��"
    
    '��С��תΪ������ȥ��С����, 123.45 -> 12345
    Myinput = Int(Abs(Myinput) * 100 + 0.5)
    If Myinput > 99999999999# Then
      mychange = "�����������ֹ���"
      Exit Function
    End If
    If Myinput = 0 Then
      mychange = "��Ԫ���"
      Exit Function
    End If
    
    MyinputA = Trim(Str(Myinput))
    shuzilong = Len(MyinputA)
    
    '��ת��12345->54321
    For J = 1 To shuzilong
    MyinputB = Mid(MyinputA, J, 1) & MyinputB
    Next
    
    '1�Ѱ���������תΪ��д�� 54321�� 5->��
    '2�����ֺͶ�Ӧλ�õĵ�λƴ�ӣ���������Ҽ����->���
    '3ƴ��ʱ��ת������ �������
    'ע��0���� shuzi2 �õ���λ�������Ǵ� Place
    '       12.10->1210->0121->  �� Ҽ�� ��Ԫ Ҽʰ
    '       10.88->1088->8801->�Ʒ� �ƽ�   Ԫ Ҽʰ
    '       30800.25->3080025->5200803->..���� Ԫ �� �ư� �� ����
    '               ->���� �� �ư� �� Ԫ ����...
    For J = 1 To shuzilong
      Temp = Val(Mid(MyinputB, J, 1))
      If Temp = 0 Then
         MyinputC = Mid(shuzi2, J, 1) & MyinputC
      Else
         MyinputC = Mid(shuzi1, Temp, 1) & Mid(Place, J, 1) & MyinputC
      End If
    Next
    
    'ϸ�ڣ�������
    '10.46          Ҽʰ��Ԫ... -> ҼʰԪ
    '10 1234.56     Ҽʰ����... -> Ҽʰ��
    '10 1234 5678.56Ҽʰ����... -> Ҽʰ��
    '30800.25       ��һ���õ������� ��   �ư� ��     Ԫ �������
    '               ע�Ⲣ���ǣ����� ��Ǫ �ư� ��ʰ ��Ԫ �������
    '30800.25       ������ư�(��)Ԫ.. ->  ������ư� Ԫ..
    shuzilong = Len(MyinputC)
    For J = 1 To shuzilong - 1
      If Mid(MyinputC, J, 1) = "��" Then
         Select Case Mid(MyinputC, J + 1, 1)
            Case "��", "Ԫ", "��", "��", "��":
            MyinputC = Left(MyinputC, J - 1) & Mid(MyinputC, J + 1, 30)
            J = J - 1
         End Select
      End If
    Next
    
    '������... -> ����...
    shuzilong = Len(MyinputC)
    For J = 1 To shuzilong - 1
       If Mid(MyinputC, J, 1) = "��" And Mid(MyinputC, J + 1, 1) = "��" Then
         MyinputC = Left(MyinputC, J) & Mid(MyinputC, J + 2, 30)
         Exit For
       End If
    Next
    
    mychange = qianzhui & Trim(MyinputC)
End Function
