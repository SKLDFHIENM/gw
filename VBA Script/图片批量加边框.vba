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


Sub ͼƬ�����ӱ߿�()
    Application.ScreenUpdating = False
    

'���´������Ƕ��ʽͼƬ�߿�
    Dim inshape As InlineShape

    For Each inshape In ActiveDocument.InlineShapes
        inshape.Select
        With inshape.Borders
            .OutsideLineStyle = wdLineStyleSingle  '�߿���'
            .OutsideColorIndex = wdColorAutomatic  '��ɫΪ�Զ�, ͨ��Ϊ��ɫ
            .OutsideLineWidth = wdLineWidth025pt   '�߿��ϸ,���ñ߿�Ϊ0.25pt
        End With
    Next
    
    
 '���´��������ͨͼƬ�߿�, ����汾 wps ��Ч.�����
    Dim myPic As shape

    For Each myPic In ActiveDocument.Shapes
        If myPic.Type = msoPicture Then   '���shape����ΪͼƬ
            myPic.Select
            Selection.ShapeRange.Line.Weight = 0.25   '���ñ߿�Ϊ0.25pt
        End If
    Next
    
    Application.ScreenUpdating = True
End Sub