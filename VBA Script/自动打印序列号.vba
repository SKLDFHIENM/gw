'�Զ���ӡ���к�
'Դ�����ַ:https://blog.csdn.net/yipiantian/article/details/124245361
'С��������Դ���޸�.

'ʹ�÷���:   
'����ƶ�����Ҫд���ŵĵط�,���б��ű�����.     Ĭ�ϸ�ʽΪ: ��N��
'������޸ı��ǰ׺�ͺ�׺.  ""������
'����Ա���и�ʽҪ��, �����ȵ����ñ������λ�õ����ָ�ʽ�����нű�, Ҳ����ֱ���޸ı��ű�.

Sub �Զ���ӡ���к�()
    Dim i As Long
    Dim lngStart    '��ʼ���
    Dim lngCount    '�������
    Dim leftWord As String
    Dim rightWord As String
    leftWord = "��"          '���к�ǰ׺
    rightWord = "��"              '���кź�׺
    lngStart = InputBox("��ʼ��ӡ���", "�����뿪ʼ��ӡ��ţ�", 1)
    If lngStart = "" Then
        Exit Sub    '��ʼ���Ϊ���˳�
    End If
    lngCount = InputBox("������ӡ���", "�����������ӡ��ţ�", 1)
    If lngCount = "" Then
        Exit Sub    '�������Ϊ���˳�
    End If
    For i = lngStart To lngCount
        Selection.Text = leftWord & Format(i, "00") & rightWord
        '00�ĸ�ʽ, ��ʾ 01 02,09,10...99,  ����Ը��������Լ�����.  ���Ϊһ��0, ��Ϊ 1,2,9,10...
        Application.PrintOut FileName:="", Range:=wdPrintAllDocument, Item:= _
        wdPrintDocumentContent, Copies:=1, Pages:="", PageType:=wdPrintAllPages, _
        ManualDuplexPrint:=False, Collate:=True, Background:=True, PrintToFile:= _
        False, PrintZoomColumn:=0, PrintZoomRow:=0, PrintZoomPaperWidth:=0, _
        PrintZoomPaperHeight:=0
        Selection.Text = ""
    Next
End Sub