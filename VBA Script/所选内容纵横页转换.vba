'====================================================================
'                            ʹ��˵��:
'
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'  ԭ����: 413191246se 
'  ��Դ:  https://club.excelhome.net/thread-1637945-1-1.html
'  �޸�: С����
'  ����: 2024��5��6��



Sub ��ѡ�����ݺ�ת��()
'�ݺ�ת��
    With Selection
        If .Type = wdSelectionIP Then End
        If .Start <> 0 Then
            ActiveDocument.Range(Start:=.Start, End:=.Start).InsertBreak Type:=wdSectionBreakNextPage
            .Start = .Start + 1
        End If
        If .End <> ActiveDocument.Content.End Then
            ActiveDocument.Range(Start:=.End, End:=.End).InsertBreak Type:=wdSectionBreakNextPage
        End If
        With .PageSetup
            If .Orientation = wdOrientPortrait Then .Orientation = wdOrientLandscape Else .Orientation = wdOrientPortrait
        End With
    End With
End Function