'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================

'  ԭ����: Bingo 260961242
'  Դ���ַ: https://club.excelhome.net/thread-1125035-1-2.html
'  �޸���: С����
'  �޸�����: 2023��2��7��

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug



Sub ���ĵ�תPDF()

Application.DisplayAlerts = True
Application.ScreenUpdating = False


Dim fDialog As FileDialog
Set fDialog = Application.FileDialog(msoFileDialogFilePicker)
Dim vrtSelectedItem As Variant
Dim wdDoc As Document
Dim i As Long

With fDialog
    .Filters.Add "Word�ļ�", "*.doc;*.docx;*.docm", 1
    If .Show = -1 Then
        For Each vrtSelectedItem In .SelectedItems
            '���ѡ���˱��ĵ�������
            If InStrRev(vrtSelectedItem, ThisDocument.Name) = 0 Then
                On Error Resume Next
                Set wdDoc = Application.Documents.Open(vrtSelectedItem, ReadOnly:=True)
                If Right(vrtSelectedItem, 4) = "docx" Then
                    wdDoc.SaveAs Left(vrtSelectedItem, Len(vrtSelectedItem) - 5), wdFormatPDF
                    i = i + 1
                 Else
                    wdDoc.SaveAs Left(vrtSelectedItem, Len(vrtSelectedItem) - 4), wdFormatPDF
                    i = i + 1
                End If
                'Debug.Print Left(vrtSelectedItem, Len(vrtSelectedItem) - 4)
                wdDoc.Close False
            End If
        Next vrtSelectedItem

    End If
End With
Set fDialog = Nothing
Application.ScreenUpdating = True
Application.DisplayAlerts = True
MsgBox (i & "���ĵ���ת��!")


End Sub