'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'ԭ����:ExtendOffice 20181128
'С���������޸�
'�÷�: ѡ���ļ��м���''

Sub Doc����תDocx()

    Dim xDlg As FileDialog
    Dim xFolder As Variant
    Dim xFileName As String
    Application.ScreenUpdating = False
    Set xDlg = Application.FileDialog(msoFileDialogFolderPicker)
    If xDlg.Show <> -1 Then Exit Sub
    xFolder = xDlg.SelectedItems(1) + "\"
    xFileName = Dir(xFolder & "*.doc", vbNormal)
    While xFileName <> ""
        Documents.Open FileName:=xFolder & xFileName, _
            ConfirmConversions:=False, ReadOnly:=False, AddToRecentFiles:=False, _
            PasswordDocument:="", PasswordTemplate:="", Revert:=False, _
            WritePasswordDocument:="", WritePasswordTemplate:="", Format:= _
            wdOpenFormatAuto, XMLTransform:=""
        ActiveDocument.SaveAs xFolder & Replace(xFileName, "doc", "docx"), wdFormatDocumentDefault
        ActiveDocument.Close
        xFileName = Dir()
    Wend
    Application.ScreenUpdating = True
    Shell "explorer.exe " & xFolder, 1
End Sub

