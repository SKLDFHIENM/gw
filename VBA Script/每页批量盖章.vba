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
'����: 2024��11��10��

Sub ��������()
Attribute ��������.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.��1"

    Dim doc As Document
    Set doc = ActiveDocument
        
    Dim ɸѡ�� As FileDialog, �ļ���, �ļ� As Document, pd, ���� As Integer
    Set ɸѡ�� = Application.FileDialog(msoFileDialogFilePicker)
    With ɸѡ��
        .Title = "��ָ������ͼƬ"
        .Filters.Add "����ͼƬ", "*.gif; *.png", 1
        .Show
    End With
    If ɸѡ��.SelectedItems.Count <= 0 Then Exit Sub     '���ȡ����ť�˳�
    
    Dim picPath As String
    picPath = ɸѡ��.SelectedItems(1)
    
    
    
    ' �����ĵ������н�
    For Each sec In doc.Sections
        ' ���һ��ˮӡ��״
        Set shp = sec.Headers(wdHeaderFooterPrimary).Shapes.AddPicture(picPath)
        
        ' ����ͼƬ��С��λ��
        With shp
            .LockAspectRatio = msoTrue
            .Width = CentimetersToPoints(3) ' �����Ϊ3����
            .Height = CentimetersToPoints(3) ' �߶���Ϊ3����
            .WrapFormat.Type = wdWrapBehind ' ͼƬ���������·�
            .Left = 350  '���ù��µ�λ��, ��Ҫ����ҳ����
            .Top = 500   '���ù��µ�λ��, ��Ҫ����ҳ��߶�'
        End With
    Next sec
    
    
    
End Sub
