'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================

'Դ����Դ:https://zhuanlan.zhihu.com/p/585845214
'С���������޸�

'Word����ʹ��Ĭ����ʽ��עƴ��
Sub ���ּ�ƴ��()
    On Error Resume Next
    Selection.WholeStory
    TextLength = Selection.Characters.Count
    Selection.EndKey
    '�˴�30���������,�ɵ���Ϊ13
    For i = TextLength To 0 Step -30
        If i < 30 Then
            Selection.MoveLeft Unit:=wdCharacter, Count:=i
            Selection.MoveRight Unit:=wdCharacter, Count:=i, Extend:=wdExtend
        Else
            Selection.MoveLeft Unit:=wdCharacter, Count:=30
            Selection.MoveRight Unit:=wdCharacter, Count:=30, Extend:=wdExtend
        End If
        SendKeys "{Enter}"
        Application.Run "FormatPhoneticGuide"
    Next
    Selection.WholeStory
End Sub
