'====================================================================
'                            ʹ��˵��:
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================
'������ο���https://zhuanlan.zhihu.com/p/63921449
'ԭ����֪��ID: koko�ɿ�
'С�����������޸�


Sub ��д��()

    Dim R_Character As Range

	'�����С��5��ֵ֮����в��������Ը�д
    Dim FontSize(5)
    FontSize(1) = "16"
    FontSize(2) = "18"
    FontSize(3) = "20"
    FontSize(4) = "17"
    FontSize(5) = "19"


    '�����е�����ָ������Ҫ���Ƶ����岨��������������������3��֮�䲨����ע�������Ҫ�������Ҳ��һ��Ҫ��
    Dim FontName(3)
    '���������⼸������֮�䲨����ע��Ҫ��ǰ��װ��Щ����(�����Լ���������д��,��һ�����⼸��)
    FontName(1) = "�������д��"
    FontName(2) = "������д"
    FontName(3) = "������д2"

    Dim ParagraphSpace(5)
    '�м�� ��һ������ֵ�о��ȷֲ����ɸ�д
    ParagraphSpace(1) = "26"
    ParagraphSpace(2) = "28"
    ParagraphSpace(3) = "30"
    ParagraphSpace(4) = "32"
    ParagraphSpace(5) = "24"

    '����ԭ��Ļ����������޸����д���
    For Each R_Character In ActiveDocument.Characters
        VBA.Randomize
        '������һ�е�2ҳ������������������������ĸ����ˣ�����ҲҪ��
        R_Character.Font.Name = FontName(Int(VBA.Rnd * 3) + 1)

        R_Character.Font.Size = FontSize(Int(VBA.Rnd * 5) + 1)

        R_Character.Font.Position = Int(VBA.Rnd * 3) + 1

        R_Character.Font.Spacing = 0
    Next
    Application.ScreenUpdating = True


	'�˶�Ϊ����м��, �ɸ�����Ҫ���û�ע�͵�
	'For Each Cur_Paragraph In ActiveDocument.Paragraphs
	'   Cur_Paragraph.LineSpacing = ParagraphSpace(Int(VBA.Rnd * 5) + 1)
	'Next
     Application.ScreenUpdating = True

End Sub