'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'����:С����
'����:2023��2��8��
'

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug


Sub ��������ͼƬ��С()
    On Error Resume Next
    
    Dim w As single
    Dim h As single
    w = InputBox("��������������ͼƬ�Ŀ��(����),0Ϊ���������,ֻ�����߶�", , 0)
    h = InputBox("��������������ͼƬ�ĸ߶�(����),0Ϊ�������߶�,ֻ�������", , 0)
    
    '����߿�Ϊ0,���˳�'
    If w = 0 And h = 0 Then
        MsgBox ("δ������,Ҳδ����߶�")
        Exit Sub
    End If
    
    
    '���δ�������������ͨͼƬ
    Dim myPic As Shape
    For Each myPic In ActiveDocument.Shapes
            If myPic.Type = msoPicture Then   'ֻ����ͼƬ,���������״,��ʽ,ͼ�������'
                myPic.Select
                If w > 0 Then
                    myPic.Width = 28.345 * w
                ElseIf h > 0 Then
                    myPic.Height = 28.345 * h
                End If
            End If
    Next
    
    '���δ�����������Ƕ��ʽͼƬ
    Dim myinPic As InlineShape
    For Each myinPic In ActiveDocument.InlineShapes
            myinPic.Select
            If w > 0 Then
                myinPic.Width = 28.345 * w
            ElseIf h > 0 Then
                myinPic.Height = 28.345 * h
            End If
    Next
End Sub
