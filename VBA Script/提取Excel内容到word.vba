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
'  ����: 2023��2��8��

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug

Sub ��ȡExcel����()

On Error Resume Next
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

If dia.SelectedItems.Count <= 0 Then Exit Sub   'ȡ���˳�'
    
Dim book As Object
Set book = xls.Workbooks.Open(dia.SelectedItems(1))



Dim sheet As Object
Set sheet = book.Worksheets(1)



Dim i As Long

Dim doc As Document
Set doc = Application.ActiveDocument


Dim cell As String

Dim r As String
r = InputBox("����Ҫ��ȡ�ķ�Χ,���� A1:A10", "��ȡExcel����", "A1:A10")

Dim c As Object

For Each c In sheet.Range(r).Cells
    cell = c.Value & Chr(9)
    doc.Range.InsertAfter cell
Next

xls.Workbooks.Close
Set xls = Nothing


End Sub
