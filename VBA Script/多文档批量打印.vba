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
'����:2023��2��13��'


Sub ������ӡWORD�ĵ�()

    On Error Resume Next

    Dim ɸѡ�� As FileDialog, �ļ���, �ļ� As Document, pd, ���� As Integer
    Set ɸѡ�� = Application.FileDialog(msoFileDialogFilePicker)
    With ɸѡ��
        .AllowMultiSelect = True
        .Title = "��ѡ��Ҫ������ӡ���ĵ�,�ɶ�ѡ"
        .Show
    End With
    If ɸѡ��.SelectedItems.Count <= 0 Then Exit Sub     '���ȡ����ť�˳�
    
    Dim ���� As Long
    ���� = InputBox("������Ҫ��ӡ�ķ���?", "С����VBA�ű�", 1)
    
    If ���� <= 0 Then Exit Sub    '���ȡ�������<=0�˳�'
    
    For Each �ļ��� In ɸѡ��.SelectedItems
        If Not Right(�ļ���, Len(�ļ���) - InStrRev(�ļ���, ".")) Like "doc*" Then GoTo ����
        Set �ļ� = Documents.Open(�ļ���)  '���ļ�
        �ļ�.PrintOut , , , , , , , ���� '�ļ���ӡ
        �ļ�.Close False  '�ļ��ر�
        ���� = ���� + 1
        Set �ļ� = Nothing
        
����:  Next
    Set ɸѡ�� = Nothing
    MsgBox "����ɣ�����ӡ��" & ���� & "���ļ�,��" & ���� & "��!"
End Sub
