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
'����:2024��8��28��'  �޸���vba�ı���������

'Դ�ű�ΪQQ1722187970, �����˼��޸�.
'������ͼƬ����Ϊ�ĵ�ͬ·���� emfͼƬ'

Sub ��������ͼƬ()
    
    
    On Error Resume Next
    
    Const adTypeBinary = 1
    'Ĭ���ı�����
    Const adTypeText = 2
    'ָ�����浽�ļ�ʱ�����ǣ�ֻ�½�
    Const adSaveCreateNotExist = 1
    'ָ�����浽�ļ�ʱ����ԭ�ļ���û�����½�
    Const adSaveCreateOverWrite = 2
    
    Dim oStream As Object
    Dim arr() As Byte
    Set oStream = VBA.CreateObject("adodb.stream")
    i = 1
    Dim oDoc As Document
    Set oDoc = Word.ActiveDocument
    Dim oSP As Shape
    Dim sPath As String
    If oDoc.Saved Then   '����ĵ��ѱ���,�Ͱ�ͼƬ��ŵ��ĵ���ͬ·��.
        sPath = oDoc.Path & "\" & oDoc.Name & "_shape_"
    Else
        MsgBox ("�ĵ�δ����,�޷���ͼƬ���浽�ĵ������ļ���.���ȱ����ĵ�!")
        Exit Sub
    End If
    
    
    
    Dim oInLineSp As InlineShape
    With oDoc
        For Each oSP In .Shapes
            oSP.Select
            arr = Word.Selection.EnhMetaFileBits
            With oStream
                .Open
                .Type = adTypeBinary
                .Write arr
                .SaveToFile sPath & i & ".emf", adSaveCreateOverWrite
                .Close
            End With
            i = i + 1
        Next
        For Each oInLineSp In .InlineShapes
            arr = oInLineSp.Range.EnhMetaFileBits
            With oStream
                .Open
                .Type = adTypeBinary
                .Write arr
                .SaveToFile sPath & i & ".emf", adSaveCreateOverWrite
                .Close
            End With
            i = i + 1
        Next
    End With
    Shell "explorer.exe " & oDoc.Path, vbMaximizedFocus
    
End Sub
