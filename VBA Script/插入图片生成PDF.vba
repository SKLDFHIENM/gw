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
'����:2023��2��2��'

'ʹ�÷���:
'���б�vba�ű�, ѡ����ͼƬ(���Զ�˳��),Ȼ��ȴ��Զ�����ͱ���Ի���


Sub ����ͼƬPDF()

    Dim ɸѡ�� As FileDialog, �ļ���, �ļ� As Document, pd, ���� As Integer
    Set ɸѡ�� = Application.FileDialog(msoFileDialogFilePicker)
    With ɸѡ��
        .AllowMultiSelect = True
        .Title = "��ѡ��Ҫ���������ͼƬ,�ɶ�ѡ"
        .Show
    End With
    If ɸѡ��.SelectedItems.Count <= 0 Then Exit Sub     '���ȡ����ť�˳�
    
    
    Dim doc As Document
    Set doc = Application.Documents.Add()
    
    With doc.PageSetup
        .PaperSize = wdPaperA4 '��ΪA4ֽ��
        .LeftMargin = 0   '������߾�Ϊ0
        .RightMargin = 0
        .TopMargin = 0
        .BottomMargin = 0
        
    End With
    
    Dim pic As InlineShape
    
    For Each �ļ��� In ɸѡ��.SelectedItems
        
        Set pic = Selection.InlineShapes.AddPicture(�ļ���)
        pic.Height = doc.PageSetup.PageHeight
        pic.Width = doc.PageSetup.PageWidth
        
    Next
    
  
    
    
    With Application.FileDialog(msoFileDialogSaveAs)
        .InitialFileName = ɸѡ��.SelectedItems.Item(1)
        .FilterIndex = 7   '7Ϊpdf,����汾���в�ͬ,�����е���'
        If (.Show = -1) Then
            .Execute
            doc.Close (False)
        End If
    End With
    
    

End Sub

