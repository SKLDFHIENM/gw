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
'  ����: 2024��1��31��
' ver1.1 �޸�msgbox��ʾ�����bug


Sub xkonglong_���ݷֽڷ�����ĵ�()

    '���δ�������: ���û�зֽڷ�,��ʾ���˳�
    If Word.ActiveDocument.Sections.Count <= 1 Then
        MsgBox "����ĵ�ǰ�����ֽڷ�!"
        Exit Sub
    End If


    '���δ�������: ѡ���ֺ�Ҫ������ļ���'
    Dim dia As FileDialog
    Set dia = Application.FileDialog(msoFileDialogFolderPicker)
    dia.Title = "��ѡ���ֺ�Ҫ������ļ���"
    If Word.ActiveDocument.Saved Then dia.InitialFileName = Word.ActiveDocument.path
    If dia.Show = 0 Then Exit Sub
    Dim sPath As String
    sPath = dia.SelectedItems(1)
    
    
    '���δ�������:����ĵ�������
    Dim oDoc As Document
    Dim nDoc As Document
    Set oDoc = Word.ActiveDocument
    Dim i As Long
    Dim j As Long
    j = oDoc.Sections.Count
    For i = 1 To j
        oDoc.Sections(i).Range.Copy   '����һ������'
        Set nDoc = Word.Documents.Add    '�½��ĵ�'
        nDoc.Content.PasteAndFormat (wdFormatOriginalFormatting) '��Դ��ʽճ�������ĵ�
        nDoc.PageSetup = oDoc.Sections(i).PageSetup   '����ԭ�ĵ�ҳ������
        Call ɾ���ֽڷ�
        nDoc.SaveAs2 sPath & "\" & oDoc.Name & "_" & i & ".docx"   '����
        nDoc.Close   '�ر����ĵ�'
    Next
End Sub

Function ɾ���ֽڷ�()

    Selection.HomeKey Unit:=wdStory
    Selection.Find.ClearFormatting
    Selection.Find.Replacement.ClearFormatting
    With Selection.Find
    .Text = "^b"
    .Replacement.Text = ""
    .Forward = True
    .Wrap = wdFindContinue
    .Format = True
    .MatchCase = False
    .MatchWholeWord = False
    .MatchWildcards = False
    .MatchSoundsLike = False
    .MatchAllWordForms = False
    End With
    Selection.Find.Execute Replace:=wdReplaceAll
    
End Function





