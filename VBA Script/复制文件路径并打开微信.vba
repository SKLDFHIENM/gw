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
'  ����: 2024��3��22��

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug

Sub �����ļ�·������΢��()
    
    On Error Resume Next
    
    Dim doc As Document
    Set doc = ActiveDocument
    
    If Not doc.Saved Then
        doc.Save  '����ļ�δ����, �ȱ��� '
    End If
    
    Dim path As String
    
    path = doc.FullName  '��ȡ�ļ�·��'
    
    '���������
    Dim RR
    Set RR = CreateObject("new:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")   'Forms 2.0 Object Library
    RR.SetText path
    RR.PutInClipboard  '�����ļ�·����������
    
    
    '��΢��, ·�������Լ���΢��·��Ϊ׼
    Shell "D:\Tools\WeChat\WeChat.exe"   '
    
    
End Sub
