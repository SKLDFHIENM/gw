'====================================================================
'                            ʹ��˵��:  
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'  ����: С����
'  �޸�����: 2023��2��14��

'  �����������Ƴ�����������������.

Sub xkonglong_�Ƴ�xlsд����()
    
    Dim xls As Object
    Set xls = CreateObject("excel.application")
    
    Dim dia As FileDialog
    Set dia = Application.FileDialog(msoFileDialogFilePicker)
    With dia
        .AllowMultiSelect = False
        .Title = "��һ��excel�ļ�"
        .Filters.Add "Excel �ļ�", "*.xls*", 1
        .Show
    End With
    
    Dim fname As String
    fname = dia.SelectedItems(1)
    

    Dim book As Object
    
    Set book = xls.Workbooks.Open(fname)
    
    Dim sht As Object
    
    'ѭ������sheetд����

    For Each sht In book.Worksheets

        sht.Protect AllowFiltering:=True

        sht.Unprotect

    Next
    book.Close (True)  'xls�ļ����沢�ر�'
    Set xls = Nothing  '�ر�excel��̨����'
    MsgBox (fname & "д���������")

End Sub

