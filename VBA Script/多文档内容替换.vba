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

'---------------------------------------------------------------------
'��ʾ����Ҫ��ʾ�˼�������:
'   1. VBA�ű��������ļ���������
'   2. �����ȿ�����Ӣ������,Ҳ����������, ʹ�����ı�����ܴ�̶��ϰ�������������

'---------------------------------------------------------------------

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug
Dim strF As String
Dim strR As String

Sub xkonglong_�����滻()

    Dim ɸѡ�� As FileDialog, �ļ���, �ļ� As Document, pd, ���� As Integer
    Set ɸѡ�� = Application.FileDialog(msoFileDialogFilePicker)
    With ɸѡ��
        .AllowMultiSelect = True
        .Title = "��ѡ��Ҫ�����滻���ĵ�,�ɶ�ѡ"
        .Show
    End With
    
    
    strF = InputBox("������Ҫ���ҵ�����,֧��ͨ���,Ĭ���ǲ����»���_", , "([_]{1,})")
    strR = InputBox("�������滻�ı�,֧��ͨ���,Ĭ���Ǹ��������ݼ�()", , "(\1)")
    
    For Each �ļ��� In ɸѡ��.SelectedItems
        If Not Right(�ļ���, Len(�ļ���) - InStrRev(�ļ���, ".")) Like "doc*" Then GoTo ����
        Set �ļ� = Documents.Open(�ļ���)
        With �ļ�.Content.find
            .ClearFormatting
            .MatchWildcards = True    '֧��ͨ���
            .Wrap = wdFindStop
            .Text = strF           'Ҫ���ҵ�����'
            With .Replacement
                .ClearFormatting
                .Text = strR        '�滻�������'
            End With
            .Execute Replace:=wdReplaceAll   '�滻����'
        End With
        �ļ�.Close wdSaveChanges     '�����ļ�'
        Debug.Print �ļ��� & " �Ѵ�����ɣ�"
        ���� = ���� + 1
        Set �ļ� = Nothing
����:  Next
    Set ɸѡ�� = Nothing
    MsgBox "����ɣ���������" & ���� & "���ļ���"
End Sub



