'====================================================================
'                            ʹ��˵��:  
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'����: С���� 
'����ѡ���ݴ�Ϊ���ĵ�

Sub SaveSelected()

    Dim doc As PageSetup
    Set doc = ActiveDocument.PageSetup
    Selection.Copy
    
    Dim newdoc As Document
    
    Set newdoc = Documents.Add(, , wdNewBlankDocument)
    newdoc.PageSetup = doc
    Selection.Paste
    newdoc.Save

End Sub