'====================================================================
'                            ʹ��˵��:
'
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'  ����: С����
'  ����: 2023��2��24��


Sub xkonglong_��ҳ����ĵ�()

    '���δ�������: ѡ���ֺ�Ҫ������ļ���'
    Dim dia As FileDialog
    Set dia = Application.FileDialog(msoFileDialogFolderPicker)
    dia.Title = "��ѡ���ֺ�Ҫ������ļ���"
    If Word.ActiveDocument.Saved Then dia.InitialFileName = Word.ActiveDocument.path
    If dia.Show = 0 Then Exit Sub
    Dim sPath As String
    sPath = dia.SelectedItems(1)
    
    
    
    Dim oDoc As Document
    Dim oRng As Range
    Dim oDocTemp As Document
    Set oDoc = Word.ActiveDocument
    
    Dim iPageNo As Long
    '��ȡ��ҳ��
    With oDoc
    iPageNo = .Range.Information(wdNumberOfPagesInDocument)
        For i = 1 To iPageNo
            '��λ��ҳ��ʼ
            Set oRng = .GoTo(wdGoToPage, Which:=wdGoToAbsolute, Count:=i)
            oRng.Select
            '��λ����ҳ������
            oRng.SetRange oRng.Start, oRng.Bookmarks("\page").End
            oRng.Copy
            '�½��ĵ�ճ�������桢�ر�'
            Set oDocTemp = Word.Documents.Add
            With oDocTemp.Application.Selection
                .Paste
            End With
            oDocTemp.SaveAs2 sPath & "\" & oDoc.Name & "_" & i & ".docx"
            oDocTemp.Close
        Next i
    End With
End Sub
