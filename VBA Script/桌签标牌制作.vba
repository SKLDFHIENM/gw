'====================================================================
'                            ʹ��˵��:  
'���� VBA �ļ�ʱ, ��ֻ����һ��Sub ����ִ��,  ������������ Function �ؼ��֡�
'Sub �������Ƽ��� �û�ID_�������� �ķ�ʽ����,��������ͻ��
'VBA �ļ���ʹ��ANSI(��������GB2312)���뱣��, ΢���VBA��������֧��UTF-8�������,�ᵼ���������롣
'����ȷ�Ĵ�����ܵ���word�������ĵ���ʧ���𻵡�
'����ر�֤vba������Դ��ȫ�ɿ���������߲��е�vba�ļ���ɵ��κ���ʧ��
'���� VBA �ļ�ʱ�����������߰�Ȩ��ע����Դ��ʾ��л��
'====================================================================

'  ԭ����: 413191246se
'  Դ���ַ: https://club.excelhome.net/thread-1649038-1-1.html
'  �޸���: С����
'  ʹ�÷���:  ����һ����ǩ������������,  �½�word�ĵ�������λ���Ա����,ÿ��һ������.���б��ļ�����


Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug
Sub xkonglong_��ǩ����()
'����
    Dim c As Cell, i&, j&
    DataInit
    With ActiveDocument
        .PageSetup.Orientation = wdOrientLandscape
        ActiveWindow.ActivePane.View.Zoom.PageFit = wdPageFitFullPage
        Selection.InsertColumnsRight
        .Tables(1).AutoFitBehavior (wdAutoFitWindow)
        j = .Tables(1).Rows.Count
        With .Tables(1)
            For i = 1 To j
                .Cell(i, 2).Range.Text = .Cell(i, 1).Range.Text
            Next i
        End With
        .Content.Find.Execute "^p", , , , , , , , , "", 2
        With .Tables(1).Range
            .Style = "��ͨ���"
            .Rows.HeightRule = wdRowHeightExactly
            .Rows.Height = CentimetersToPoints(14.6)
            .Cells.VerticalAlignment = wdCellAlignVerticalCenter
            .ParagraphFormat.Alignment = wdAlignParagraphCenter
            With .Font
                .NameFarEast = "����"
                .Size = 72
                .Bold = True
            End With
            .Columns(1).Select
            .Orientation = wdTextOrientationDownward
            For Each c In .Columns(2).Cells
                c.Range.Orientation = wdTextOrientationUpward
            Next
        End With
    End With
    LastPound
    ActiveWindow.View.TableGridlines = True
    Selection.HomeKey 6
End Sub


Function DataInit()
    Dim c As Cell
    With ActiveDocument
        .Content.Find.Execute "^l", , , 0, , , , , , "^p", 2
        .Select
        Selection.ClearFormatting
        DeleteBlankSpace
        DeleteBlankLines
        If .Tables.Count = 0 Then
            .Content.ConvertToTable 0, 1
        ElseIf .Tables.Count = 1 Then
            .Content.Find.Execute "^p", , , 0, , , , , , "", 2
        Else
            MsgBox "����һ��", 0 + 16: End
        End If
        With .Tables(1)
            .Select
            TableDeleteBlankRows
            For Each c In .Range.Cells
                With c.Range
                    If .Text Like "????" Then .Characters(1).InsertAfter Text:="  "
                End With
            Next
            .Select
        End With
    End With
End Function


Function LastPound()
'���һ��
    With ActiveDocument.Paragraphs
        With .Last.Range
            If .Text = vbCr Then .Delete
        End With
        With .Last.Range
            If .Text = vbCr Then
                With .Font
                    .Size = 1
                    .Kerning = 0
                    .DisableCharacterSpaceGrid = True
                End With
                With .ParagraphFormat
                    .LineSpacing = LinesToPoints(0.06)
                    .AutoAdjustRightIndent = False
                    .DisableLineHeightGrid = True
                End With
            End If
        End With
    End With
End Function


Function DeleteBlankLines()
'ɾ������
    Dim i As Paragraph
    For Each i In ActiveDocument.Paragraphs
        With i.Range
            If Not .Information(12) Then
                If Asc(.Text) = 13 Then .Delete
            End If
        End With
    Next
End Function

Function DeleteBlankSpace()
'ɾ���ո�
    ActiveDocument.Content.Find.Execute "[ ��^s^t]", , , 1, , , , , , "", 2
End Function

Function TableDeleteBlankRows()
'���ɾ������
    Dim r As Row
    For Each r In Selection.Tables(1).Rows
        If Len(Replace(Replace(r.Range, vbCr, ""), Chr(7), "")) = 0 Then r.Delete
    Next
End Function