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
'  ��������: 2024��7��5��


Sub �����ļ�����·��()

    Dim sContent
    Dim oDataObject
    
    sContent = LocalPath()
    
    Set oDataObject = CreateObject("new:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")
    With oDataObject
        '��DataObject����д������
        .SetText sContent
        '��DataObject��������ݴ��������
        .PutInClipboard
        '���������е����ݴ���DataObject������
        
    End With
    
End Sub
    
Public Function LocalPath() As String
    Dim ShortName As String
    Dim i%
    ShortName = ActiveDocument.FullName
    If VBA.InStr(1, ActiveDocument.FullName, "http") >= 1 Then '�������ļ��������ļ�
        'MsgBox ShortName
        ShortName = VBA.Replace(ShortName, "/", "\")
        For i = 1 To 4 'ɾ����Onedrive·���йص�ǰ׺:
            ShortName = VBA.Mid(ShortName, InStr(1, ShortName, "\", vbTextCompare) + 1)
    '        Debug.Print i & ":   " & ShortName
        Next i
          LocalPath = VBA.Environ("OneDrive") & "\" & ShortName
    Else
          LocalPath = ActiveDocument.FullName
    End If
	'MsgBox LocalPath
    
End Function