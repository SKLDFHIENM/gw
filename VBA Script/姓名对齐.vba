'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'����: С����'
'����:2023��2��4��'


Sub xkonglong_��ѡ��������()
    
    Dim n As Long
    n = InputBox("��ȷ����ѡ����δ�ÿո����,��ʹ�ñ�����." & Chr(13) & "��ѡ�������ֶ���? ������һ������(Ĭ��Ϊ��������):", "С����VBA", 3)
    If IsNumeric(n) = False Then
        n = 3
    End If
    
    Dim w As Double
    w = n * Selection.Font.Size
    
    Selection.find.ClearFormatting
    Selection.find.Replacement.ClearFormatting
    With Selection.find
        .Text = " "
        .Replacement.Text = "^p"
        .Forward = False
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchByte = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = True
    End With
    Selection.find.Execute Replace:=wdReplaceAll
    Selection.Range.FitTextWidth = w
End Sub


