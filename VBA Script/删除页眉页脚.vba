'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================

'  ԭ����: chinablank
'  Դ���ַ: https://club.excelhome.net/thread-716702-1-3.html
'  �޸���: С����
'  �޸�����: 2023��1��31��

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug
Sub xkonglong_ɾ��ҳüҳ��()
    On Error Resume Next
    Dim oSec As Section
    Dim mydoc As Document
    Dim i As Long
    
    Application.ScreenUpdating = False
    With ActiveDocument
        .ActiveWindow.View.Type = wdPrintView
        For Each oSec In mydoc.Sections '�ĵ��Ľ���ѭ��
            For i = 9 To 10
                .ActiveWindow.View.SeekView = i '9-wdSeekCurrentPageHeader,10-wdSeekCurrentPageFooter
                .Application.Selection.WholeStory
                .Application.Selection.Delete
                .ActiveWindow.View.SeekView = 0 ' wdSeekMainDocument
                .Styles("ҳü").ParagraphFormat.Borders(wdBorderBottom).LineStyle = wdLineStyleNone  'ɾ��ҳü����
            Next
        Next
    End With
    Application.ScreenUpdating = True
    MsgBox "ҳüҳ��ɾ����ϣ�"
End Sub
