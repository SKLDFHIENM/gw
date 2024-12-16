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
'  �޸ĸ�������: 2023��3��13��

 '------------------------------------------------------------------------
 '�ĵ�������Ҫ���ڸ���, ���䲻�Ƽ�ͼ���Ű�ʹ�ñ��ű�
 '------------------------------------------------------------------------
 

Option Explicit    'ǿ�����������Ǹ���ϰ��, ������ߴ����ٶ�,����bug

Sub xkonglong_�Զ��Ű�()
'����
    Initial   '��ʼ��,.
    GWStyle  '���ķ��
    Title1  '����
    Inscribe '���
    PageNumGW   '����ҳ��
    Common '�������ֵ���
    'xbs '������Ϊ����С����,������ɾ������ǰ�ĵ�����
End Sub

Function Initial()
'��ʼ��
    Dim t As Table

    'ҳ������/Ĭ��A4
    PaperSetup

    'ҳ��/����ˢ��
    ActiveWindow.ActivePane.View.Zoom.PageFit = wdPageFitBestFit

    With ActiveDocument
        'ͨ��ģ��������ʽ���Ƶ���ĵ�
        .CopyStylesFromTemplate Template:=.AttachedTemplate.FullName

        'ɾ����
        .Fields.Unlink

        '�б���ת�ı�
        .ConvertNumbersToText

        '�ֶ����з�->������
        With .Content.Find
            .Execute "^l", , , 0, , , , , , "^p", 2
            .Execute "([��.����])([ ��^s^t]{1,})", , , 1, , , , , , "\1", 2
            .Execute "(^13��)([!һ-�O])", , , 1, , , , , , "\1��\2", 2
            .Execute "����", , , , , , , , , "����", 2
        End With

        'ȡ������/����
        For Each t In .Tables
            With t.Range.Rows
                .WrapAroundText = False
                .Alignment = wdAlignRowCenter
            End With
        Next
    End With
End Function

Function PaperSetup()
' ҳ������, �˴�������޸ı߾�
    Dim Sec As Section
    For Each Sec In ActiveDocument.Sections
        With Sec.PageSetup
            If .Orientation = wdOrientPortrait Then
                .TopMargin = CentimetersToPoints(2.54)  '�ϱ߾�
                .BottomMargin = CentimetersToPoints(2.54)
                .LeftMargin = CentimetersToPoints(3.17)
                .RightMargin = CentimetersToPoints(3.17)
                .PageWidth = CentimetersToPoints(21)   'ҳ����
                .PageHeight = CentimetersToPoints(29.7)
            Else
                .TopMargin = CentimetersToPoints(2.5)
                .BottomMargin = CentimetersToPoints(2.5)
                .LeftMargin = CentimetersToPoints(2.54)
                .RightMargin = CentimetersToPoints(2.54)
                .PageWidth = CentimetersToPoints(29.7)
                .PageHeight = CentimetersToPoints(21)
            End If
            .HeaderDistance = CentimetersToPoints(1.5)
            .FooterDistance = CentimetersToPoints(1.75)
        End With
    Next
End Function

Function GWStyle()
'������ʽ
    Dim doc As Document, i As Paragraph, r(), n As Long, t2&, t3&, t4&, t5&

    Set doc = ActiveDocument

    'skip table/code by sylun
    With doc
        ReDim r(.Tables.Count + 1)

        If .Tables.Count = 0 Then
            Set r(1) = .Content
        Else
            For n = 1 To .Tables.Count
                If n = 1 Then
                    Set r(n) = .Range(0, .Tables(n).Range.Start)
                Else
                    Set r(n) = .Range(.Tables(n - 1).Range.End, .Tables(n).Range.Start)
                End If
            Next
            Set r(n) = .Range(.Tables(n - 1).Range.End, .Content.End)
        End If
    End With

    For n = 1 To UBound(r)
        With r(n)
            .Select

            'ɾ��������β�ո�
            CommandBars.FindControl(ID:=122).Execute

            '�����ʽ
            Selection.ClearFormatting

            '������ʽ
            With .Font
                .Name = "����"
                .Size = 16
                .Color = wdColorBlue
                .Kerning = 0
                .DisableCharacterSpaceGrid = True
            End With
            With .ParagraphFormat
                .LineSpacing = LinesToPoints(1.5)
                .CharacterUnitFirstLineIndent = 2
                .AutoAdjustRightIndent = False
                .DisableLineHeightGrid = True
            End With

            If .Start <> 0 Then .InsertParagraphBefore

            With .Find
                .Execute "(^13)([һ�����������߰˾�ʮ���㩖��Oo0���ϣ�]@)(��)", , , 1, , , , , , "\1һ\3", 2
                .Execute "(^13)([(��][һ�����������߰˾�ʮ���㩖��Oo0���ϣ�]@[��)])", , , 1, , , , , , "\1��һ��", 2
                .Execute "(^13)([0-9��-��]@[��.��])", , , 1, , , , , , "\11��", 2
                .Execute "(^13)[(��][0-9��-��]@[��)]", , , 1, , , , , , "\1��1��", 2
            End With

            'Title2345Style/Format/AutoNum    �����ʽ/�Զ����
            For Each i In .Paragraphs
                With i.Range
                    If .Text Like "һ��*" Then
                        .Style = wdStyleHeading2
                        .Font.Color = wdColorRed

                        t2 = t2 + 1
                        t3 = 0
                        t4 = 0
                        t5 = 0
                        doc.Range(Start:=.Start, End:=.Characters(InStr(.Text, "��")).Start).Select
                        
                        'С�����޸�,Դ������
                        Selection.Fields.Add Range:=Selection.Range, Text:="= " & t2 & " \* CHINESENUM3"

                        

                    ElseIf .Text Like "��һ��*" Then
                        .Style = wdStyleHeading3
                        .Font.Color = wdColorPink
                        .Font.NameFarEast = "����"

                        t3 = t3 + 1
                        t4 = 0
                        t5 = 0
                        doc.Range(Start:=.Start + 1, End:=.Characters(InStr(.Text, "��")).Start).Select
                        
                        'С�����޸�,Դ������
                        
                        Selection.Fields.Add Range:=Selection.Range, Text:="= " & t3 & " \* CHINESENUM3"
                        

                    ElseIf .Text Like "#��*" Then
                        .Style = wdStyleHeading4
                        .Font.Color = wdColorGreen
                        With .Font
                            .Name = "����"
                            .Size = 16
                        End With
                        With .ParagraphFormat
                            .SpaceBefore = 13
                            .SpaceAfter = 13
                        End With

                        t4 = t4 + 1
                        t5 = 0
                        doc.Range(Start:=.Start, End:=.Characters(InStr(.Text, "��")).Start).Text = t4

                    ElseIf .Text Like "��#��*" Then
                        .Style = wdStyleHeading5
                        .Font.Color = wdColorOrange
                        With .Font
                            .Name = "����"
                            .Size = 16
                        End With
                        With .ParagraphFormat
                            .SpaceBefore = 13
                            .SpaceAfter = 13
                        End With

                        t5 = t5 + 1
                        doc.Range(Start:=.Characters(1).End, End:=.Characters(InStr(.Text, "��")).Start).Text = t5

                    ElseIf Asc(.Text) = 13 Then
                        .Delete

                    ElseIf .Text Like "[!^13]����*" Or .Text Like "����*" Then
                        t2 = 0
                        t3 = 0
                        t4 = 0
                        t5 = 0
                    End If

                    If .Style Like "����*" Then
                        .Font.Kerning = 0
                        With .ParagraphFormat
                            .LineSpacing = LinesToPoints(1.5)
                            .CharacterUnitFirstLineIndent = 1.99
                            .AutoAdjustRightIndent = False
                            .DisableLineHeightGrid = True
                            .KeepWithNext = False
                            .KeepTogether = False
                        End With

                        If .Sentences(1) Like "*��??*" Then
                            .MoveStart 1, InStr(.Text, "��")
                            With .Font
                                .Name = "����"
                                .Bold = False
                                .Color = wdColorBlue
                            End With

                            If .Paragraphs(1).Range.Style Like "����*" & "[23]" Then
                                If .Text Like "*[������������������.:;,!?]?" Then
                                    .Characters.Last.Previous.Delete
                                End If
                            ElseIf .Paragraphs(1).Range.Style Like "����*" & "[45]" Then
                                If .Text Like "*[!������������������.:;,!?]?" Then
                                    If .Text Like "*[!0-9a-zA-Z]?" Then
                                        .Characters.Last.InsertBefore Text:="��"
                                    End If
                                End If
                            End If
                        Else
                            If .Sentences.Count = 1 Then
                                If .Text Like "*[������������������.:;,!?]?" Then .Characters.Last.Previous.Delete
                            Else
                                With doc.Range(Start:=.Sentences(1).End, End:=.End).Font
                                    .Name = "����"
                                    .Bold = False
                                    .Color = wdColorBlue
                                End With
                            End If
                        End If
                    End If
                End With
            Next

            If .Start <> 0 Then
                If Len(.Text) <> 0 Then
                    .InsertParagraphBefore
                    With .Paragraphs(1).Range
                        .Font.Size = 6
                        With .ParagraphFormat
                            .SpaceBefore = 0
                            .SpaceAfter = 0
                        End With
                    End With
                End If
            End If
        End With
    Next
End Function


Function Title1()
'һ������
    Dim doc As Document, i As Paragraph

    Set doc = ActiveDocument

    With doc.Paragraphs(1).Range
        If .End <> doc.Content.End Then
            If Not (.Next(4, 1) Like "*[������������������.:;,!?]?" Or .Next(4, 1) Like "[һ1][��.��]*" Or .Next(4, 1) Like "��[һ1]��*" Or .Next(4, 1) Like "��[һ1]*" Or .Next.Information(12)) Then .MoveEnd 4
        End If
        If .End <> doc.Content.End Then
            If Not (.Next(4, 1) Like "*[������������������.:;,!?]?" Or .Next(4, 1) Like "[һ1][��.��]*" Or .Next(4, 1) Like "��[һ1]��*" Or .Next(4, 1) Like "��[һ1]*" Or .Next.Information(12)) Then .MoveEnd 4
        End If
        If .End <> doc.Content.End Then
            .Characters.Last.InsertParagraphBefore
        End If
        .InsertParagraphBefore
        .Style = wdStyleHeading1
        .Borders(wdBorderBottom).LineStyle = wdLineStyleNone
        .Font.Kerning = 0
        With .ParagraphFormat
            .SpaceBeforeAuto = False
            .SpaceAfterAuto = False
            .SpaceBefore = 0
            .SpaceAfter = 0
            .LineSpacing = LinesToPoints(1.15)
            .Alignment = wdAlignParagraphCenter
            .AutoAdjustRightIndent = False
            .DisableLineHeightGrid = True
        End With
        With .Characters
            .First.Font.Size = 21
            .Last.Font.Size = 26
        End With

        '�ƺ�
        If .End <> doc.Content.End Then
            With .Next(4, 1)
                If Not .Information(12) Then
                    If .Text Like "*[��:]?" Then
                        If .ComputeStatistics(1) < 3 Then
                            .Characters.Last.Previous.Text = "��"
                            With .Find
                                .Execute "(", , , 0, , , , , , "��", 2
                                .Execute ")", , , 0, , , , , , "��", 2
                            End With
                            .Font.Color = wdColorViolet
                            With .ParagraphFormat
                                .CharacterUnitFirstLineIndent = 0
                                .FirstLineIndent = CentimetersToPoints(0)
                            End With
                        End If
                    End If
                End If
            End With
        End If

        '�ո�
        With .Find
            .Execute "(", , , 0, , , , , , "��", 2
            .Execute ")", , , 0, , , , , , "��", 2
            .Execute "[ ��^s^t]", , , 1, , , , , , "", 2
        End With

        '���ݸ壩
        With .Paragraphs.Last.Previous.Range
            If .Text Like "��*��?" Then
                With .Font
                    .NameFarEast = "����"
                    .Size = 18
                    .Color = wdColorTeal
                End With
                .Paragraphs.IncreaseSpacing
                If Len(.Text) = 6 Then
                    .Characters(2).InsertAfter Text:=" "
                    .Characters(4).InsertAfter Text:=" "
                ElseIf Len(.Text) = 5 Then
                    .Characters(2).InsertAfter Text:=" "
                End If
                .Next.ParagraphFormat.Space1
            End If

            '�ӿ�
            If Not .Text Like "*��*" Then
                If .Text Like "???" Then
                    .Characters(1).InsertAfter Text:="    "
                ElseIf .Text Like "????" Then
                    If .Text Like "Э����?" Then .Font.Size = 26
                    .Characters(1).InsertAfter Text:="   "
                    .Characters(5).InsertAfter Text:="   "
                ElseIf .Text Like "?????" Then
                    .Characters(1).InsertAfter Text:="  "
                    .Characters(4).InsertAfter Text:="  "
                    .Characters(7).InsertAfter Text:="  "
                ElseIf .Text Like "??????" Then
                    .Characters(1).InsertAfter Text:="  "
                    .Characters(4).InsertAfter Text:="  "
                    .Characters(7).InsertAfter Text:="  "
                    .Characters(10).InsertAfter Text:="  "
                ElseIf .Text Like "???????" Then
                    .Characters(1).InsertAfter Text:=" " & ChrW(160)
                    .Characters(4).InsertAfter Text:=" " & ChrW(160)
                    .Characters(7).InsertAfter Text:=" " & ChrW(160)
                    .Characters(10).InsertAfter Text:=" " & ChrW(160)
                    .Characters(13).InsertAfter Text:=" " & ChrW(160)
                End If
            End If
        End With

        For Each i In .Paragraphs
            With i.Range
                If .Text Like "[!��]*[��������]?" Then .InsertBefore Text:=" "
                If .Text Like "[��������]*[!��]?" Then .ParagraphFormat.CharacterUnitLeftIndent = -0.5
            End With
        Next

        '���
        If .Next.Information(12) Then
            .Characters.First.Delete
            .Characters.Last.Delete
            .ParagraphFormat.Space15
        End If
    End With
End Function

Function Inscribe()
'���
    Dim doc As Document, r As Range, arr, TextSize&, Base!, lenUnit&, k&

    Set doc = ActiveDocument

    '2022-12-09
    Set r = doc.Content
    With r.Find
        .ClearFormatting
        .Text = "^13[0-9]{4}?[0-9]{1,2}?[0-9]{1,2}[^13^12]"
        .Forward = True
        .MatchWildcards = True
        Do While .Execute
            With .Parent
                .MoveStart
                .Characters(5).Text = "��"
                .Characters.Last.InsertBefore Text:="��"
                If .Characters(7) Like "[0-9]" Then
                    .Characters(8).Text = "��"
                Else
                    .Characters(7).Text = "��"
                End If
                .Start = .End
            End With
        Loop
    End With

    Set r = doc.Content
    With r.Find
        .ClearFormatting
        .Text = "^13[0-9]{4}��[0-9]{1,2}��[0-9]{1,2}��[^13^12]"
        .Forward = True
        .MatchWildcards = True
        Do While .Execute
            With .Parent
                .MoveStart
                If .Text Like "*0?��*" Then .Characters(6).Delete
                If .Text Like "*0?��*" Then .Characters.Last.Previous.Previous.Previous.Delete
                If Not .Font.Size = 22 Then k = 1: Exit Do
                .Start = .End
            End With
        Loop
        If k = 0 Then Exit Function
    End With

    'date
    With r
        .Font.Color = wdColorPink
        TextSize = .Font.Size

        With .ParagraphFormat
            .Alignment = wdAlignParagraphRight
            If TextSize = 16 Then .CharacterUnitRightIndent = 5.9 Else .CharacterUnitRightIndent = 7
        End With

        If TextSize = 16 Then
            If .Text Like "*��?��?��?" Then
                Base = 18.22
            ElseIf .Text Like "*��?��??��?" Or .Text Like "*��??��?��?" Then
                Base = 17.97
            Else
                Base = 17.72
            End If
        Else
            If .Text Like "*��?��?��?" Then
                Base = 20.7
            ElseIf .Text Like "*��?��??��?" Or .Text Like "*��??��?��?" Then
                Base = 20.45
            Else
                Base = 20.2
            End If
        End If

        'unit
        With .Previous(4, 1)
            If .Text Like "*[!������������������.:;,!?]?" Then
                .Font.Color = wdColorRed
                .InsertBefore Text:=vbCr & vbCr & vbCr
                .SetRange Start:=.Paragraphs.Last.Range.Start, End:=.Paragraphs.Last.Range.End
                lenUnit = Len(.Text) - 1

                If lenUnit = 9 Then
                    .Font.Spacing = 1
                ElseIf lenUnit = 8 Then
                    .Font.Spacing = 2
                ElseIf lenUnit = 2 Then
                    .Characters(1).InsertAfter Text:="  "
                ElseIf lenUnit = 3 Then
                    .Characters(1).InsertAfter Text:=" "
                    .Characters(3).InsertAfter Text:=" "
                ElseIf lenUnit = 4 Then
                    .Font.Spacing = 3
                ElseIf lenUnit = 5 Then
                    .Font.Spacing = 1
                End If

                If TextSize = 16 Then
                    arr = Array(1.2, 1.6, 6.5, 4.15, 2.7, 3.35, 7.45, 6.45, 5, 5.5, 6.1, 6.6, 7.2, 7.7, 8.25, 9.25, 10.25, 11.25, 12.25, 13.25, 14.25, 15.25, 16.25, 17.25)
                Else
                    arr = Array(1.2, 1.7, 7.85, 4.85, 2.75, 3.35, 8.55, 7.15, 5.15, 5.65, 6.25, 6.75, 7.15, 7.75, 8.35, 8.4, 9.3, 10.45, 11.35, 12.45, 13.45, 14.45, 15.45, 16.45)
                End If
                .ParagraphFormat.CharacterUnitFirstLineIndent = Base - arr(lenUnit - 2)

                'date-indent
                With .Next(4, 1).ParagraphFormat
                    If lenUnit < 17 Then
                    ElseIf lenUnit = 17 Then
                        .CharacterUnitRightIndent = 6.5
                    ElseIf lenUnit = 18 Then
                        .CharacterUnitRightIndent = 7
                    ElseIf lenUnit = 19 Then
                        .CharacterUnitRightIndent = 7.85
                    ElseIf lenUnit = 20 Then
                        .CharacterUnitRightIndent = 8.52
                    ElseIf lenUnit = 21 Then
                        .CharacterUnitRightIndent = 9.2
                    ElseIf lenUnit = 22 Then
                        .CharacterUnitRightIndent = 9.88
                    ElseIf lenUnit = 23 Then
                        .CharacterUnitRightIndent = 10.55
                    ElseIf lenUnit = 24 Then
                        .CharacterUnitRightIndent = 11.22
                    ElseIf lenUnit >= 25 Then
                        lenUnit = 25
                        .CharacterUnitRightIndent = 12
                    End If
                End With
            Else
                .InsertParagraphAfter
                Exit Function
            End If
        End With
    End With

    If doc.Content Like "*" & vbCr & "��*" = False Then Exit Function
'����
    Dim DateRange As Range, myRange As Range, i As Paragraph, j&, n&, oBefore&, oAfter&, oTitle$
'ǰ����
    Set DateRange = r
    Set r = doc.Range(Start:=0, End:=DateRange.End)
    With r.Find
        .ClearFormatting
        .Text = "^13����*^13"
        .Forward = True
        .MatchWildcards = True
        .Execute
        If .Found = True Then
            With .Parent
                .MoveStart
                Do
                    .MoveEnd 4
                Loop Until .Text Like "*" & vbCr & vbCr
                .MoveEnd 1, -1
                .InsertParagraphBefore
                .MoveStart
                oBefore = 1
                Set myRange = r
            End With
        End If
    End With
'�󸽼�
sc:
    Set r = doc.Range(Start:=DateRange.End - 1, End:=doc.Content.End)
    With r.Find
        .ClearFormatting
        .Text = "[^13^12]����*^13"
        .Forward = True
        .MatchWildcards = True
        Do While .Execute
            With .Parent
                If Asc(.Text) = 13 Then
                    .Characters(1).InsertAfter Text:=Chr(12)
                ElseIf Asc(.Text) = 12 Then
                    .MoveStart 1, -1
                End If
                .MoveStart 1, 2

                'special
                Do While .Next(4, 1) Like "#��*" & vbCr Or .Next(4, 1) Like "##��*" & vbCr
                    .MoveEnd 4
                    If .End = doc.Content.End Then
                        oTitle = .Text
                        .Delete
                        .Previous.Delete
                        .Delete
                        oAfter = 1
                        GoTo sk
                    End If
                Loop

                .MoveEnd 1, -1
                n = n + 1
                .Text = "����" & n & "��"

                With .Font
                    .NameFarEast = "����"
                    .NameAscii = "Times New Roman"
                    .Bold = True
                    .Color = wdColorRed
                End With
                With .ParagraphFormat
                    .CharacterUnitFirstLineIndent = 0
                    .FirstLineIndent = CentimetersToPoints(0)
                End With

                'title
                With .Next(4, 1)
                    If Not .Information(12) Then
                        If Not (.Next.Information(12)) Then
                            If Not (.Next(4, 1) Like "*[����:_]*" Or .Next(4, 1) Like "[һ1][��.��]*" Or .Next(4, 1) Like "��[һ1]��*" Or .Next(4, 1) Like "��һ*") Then
                                .MoveEnd 4
                                .Paragraphs(1).Range.Characters.Last.Delete
                            End If
                        End If
                        If Not (.Next.Information(12)) Then
                            If Not (.Next(4, 1) Like "*[����:_]*" Or .Next(4, 1) Like "[һ1][��.��]*" Or .Next(4, 1) Like "��[һ1]��*" Or .Next(4, 1) Like "��һ*") Then
                                .MoveEnd 4
                                .Paragraphs(1).Range.Characters.Last.Delete
                            End If
                        End If
                    Else
                        .Next.Next.Select
                        Selection.SplitTable
                        Selection.Previous.Tables(1).Rows.ConvertToText Separator:=wdSeparateByParagraphs, NestedTables:=True
                        .Next(4, 1).Delete
                        .Expand 4
                    End If

                    .Find.Execute "[ ��^s^t]", , , 1, , , , , , "", 2

                    oTitle = oTitle & .Text
                    With .Font
                        .NameFarEast = "����"
                        .NameAscii = "Times New Roman"
                        .Size = 20
                        .Bold = True
                        .Color = wdColorAutomatic
                    End With
                    With .ParagraphFormat
                        .CharacterUnitFirstLineIndent = 0
                        .FirstLineIndent = CentimetersToPoints(0)
                        .Alignment = wdAlignParagraphCenter
                    End With
                    If .Sections(1).PageSetup.Orientation = wdOrientPortrait Then
                        .InsertParagraphBefore
                        .Characters.Last.InsertBefore Text:=vbCr
                        .ParagraphFormat.LineSpacing = LinesToPoints(1.25)
                    End If
                    .Paragraphs.Last.Range.ParagraphFormat.Space15
                    If .Text Like "*[��������]?" Then .InsertBefore Text:=" "
                    If .Text Like "[��������]*[!��]?" Then .ParagraphFormat.CharacterUnitLeftIndent = -0.5
                End With
                oAfter = 1
                .Start = .End
            End With
        Loop
    End With

    'logo miss
    With r
        If oAfter = 0 And Len(.Text) > 1 Then
            If .Text Like vbCr & Chr(12) & "*" Then
                .Characters(2).InsertAfter Text:="������" & vbCr
            ElseIf .Text Like vbCr & "*" Then
                .Characters(1).InsertAfter Text:="������" & vbCr
            ElseIf .Characters(2).Information(12) Then
                .Characters(2).Select
                With Selection
                    .SplitTable
                    .TypeText Text:="������"
                    With .Paragraphs(1).Range
                        .Font.Size = 16
                        With .ParagraphFormat
                            .LineSpacing = LinesToPoints(1.5)
                            .AutoAdjustRightIndent = False
                            .DisableLineHeightGrid = True
                        End With
                    End With
                End With
            End If
            GoTo sc
        End If
        If n = 1 Then .Previous.Previous.Delete
    End With
    If oBefore = 0 And oAfter = 0 Then Exit Function
'����
    If oBefore = 1 Then
        If oAfter = 1 Then
            With myRange
                If .Text Like "����[��:]" & vbCr & "*" Then .Paragraphs(1).Range.Delete
                If .Paragraphs.Count = n Then
                    .Text = oTitle
                Else
                    If MsgBox("<ǰ����> " & .Paragraphs.Count & " ����" & vbCr & .Text & vbCr _
                        & "<�󸽼�> " & n & " ����" & vbCr & oTitle & vbCr & "* ���ǰ�󸽼�������һ�£���ѡ��" & vbCr _
                        & "[��(Y)] ��<ǰ����>Ϊ׼��     [��(N)] ��<�󸽼�>Ϊ׼��", 4 + 16) = vbNo Then .Text = oTitle
                End If
            End With
        End If
    Else
sk:
        If oAfter = 1 Then
            With DateRange
                .MoveStart 4, -4
                .InsertBefore Text:=vbCr & oTitle
                .MoveStart
                .MoveEnd 4, -5
            End With
            Set myRange = DateRange
        End If
    End If
'����
    With myRange
        With .Font
            .Color = wdColorBrown
            .Bold = False
        End With
        With .ParagraphFormat
            .SpaceBefore = 0
            .SpaceAfter = 0
        End With

        For Each i In .Paragraphs
            With i.Range
                If .Text Like "��*" Then .Characters(1).Delete
                If .Text Like "��*" Then .Characters(1).Delete
                If .Text Like "��*" Then .Characters(1).Delete
                If .Text Like "[һ�����������߰˾�ʮ]*" Then .Characters(1).Delete
                If .Text Like "#[��:.������]*" Or .Text Like "##[��:.������]*" Then .Characters(1).Delete
                If .Text Like "#[��:.������]*" Or .Text Like "##[��:.������]*" Then .Characters(1).Delete
                If .Text Like "[��:.������]*" Then .Characters(1).Delete
                If .Text Like "��*" Then .Characters(1).Delete
                If .Text Like "*��?" Then .Characters.Last.Previous.Delete

                If .Text Like "#[��:.������]*" Or .Text Like "##[��:.������]*" Then .Characters(1).Delete
                If .Text Like "#[��:.������]*" Or .Text Like "##[��:.������]*" Then .Characters(1).Delete
                If .Text Like "[��:.������]*" Then .Characters(1).Delete
            End With
        Next

        If oBefore = 1 And oAfter = 0 Then n = myRange.Paragraphs.Count

        If n = 1 Then
            .InsertBefore Text:=vbTab
        Else
            For Each i In .Paragraphs
                j = j + 1
                i.Range.InsertBefore Text:=j & "��" & vbTab
            Next
        End If

        With .ParagraphFormat
            .CharacterUnitLeftIndent = 7.68
            .CharacterUnitFirstLineIndent = -1.56
        End With

        .InsertBefore Text:="������"

        With .Paragraphs(1).Range.ParagraphFormat
            .CharacterUnitLeftIndent = 3.05
            .CharacterUnitFirstLineIndent = -4.62
        End With

        If n = 1 Then .ParagraphFormat.CharacterUnitFirstLineIndent = -3.1
    End With
End Function

Function PageNumGW()
'����ҳ��, Ϊ�˼���wps,С�����޸��˸ö�ʵ��ԭ��.
    Dim Rng As Range
    With ActiveDocument.Sections(1)
        With .Footers(wdHeaderFooterPrimary)
            .Range.Delete
            If .Parent.Parent.ComputeStatistics(wdStatisticPages) > 2 Then
                Set Rng = .Range
                Rng.Text = "�� "
                Rng.Collapse wdCollapseEnd
                ActiveDocument.Fields.Add Rng, wdFieldPage, "Page"
                .Range.Fields.Update
                Set Rng = .Range
                Rng.Collapse wdCollapseEnd
                Rng.Text = " ��"
                .Range.ParagraphFormat.Alignment = wdAlignParagraphCenter
                .Range.Font.Name = "����"
                .Range.Font.Size = 14
            End If
        End With
        .Headers(wdHeaderFooterPrimary).Range.ParagraphFormat.Borders(wdBorderBottom).LineStyle = wdLineStyleNone
    End With
End Function

Function Common()
    NumPages  'ҳ��
    StyleReset   '������ʽ
    Selection.HomeKey Unit:=wdStory
    AutoColor  '����ָ�ΪĬ����ɫ
'    Xbs      '������Ϊ����С���μ���,���û�и�����, ����.
End Function

Function NumPages()
'ҳ��
    Dim p&
    p = ActiveDocument.ComputeStatistics(wdStatisticPages)
    With ActiveWindow.ActivePane.View.Zoom
        If p < 99 Then
            If .PageColumns = p Then .PageColumns = 3 Else .PageColumns = p
        Else
            If .PageColumns = 15 Then .PageColumns = 3 Else .PageColumns = 15
        End If
        .PageRows = 1
    End With
End Function

Function StyleReset()
'���ù�����ʽ, �˴����޸�Ĭ������
    With ActiveDocument
        With .Styles(wdStyleNormal).Font  '����
            .NameFarEast = "����"
            .NameAscii = "Times New Roman"
        End With

        With .Styles(wdStyleHeading1).Font  'һ������
            .NameFarEast = "����"
            .NameAscii = "Times New Roman"
        End With

        With .Styles(wdStyleHeading2).Font   '��������
            .NameFarEast = "����"
            .NameAscii = "Arial"
        End With

        With .Styles(wdStyleHeading3).Font   '��������
            .NameFarEast = "����"
            .NameAscii = "Times New Roman"
        End With

        With .Styles(wdStyleHeading4).Font   '�ļ�����
            .NameFarEast = "����"
            .NameAscii = "Arial"
        End With

        With .Styles(wdStyleHeading5).Font  '�弶����
            .NameFarEast = "����"
            .NameAscii = "Times New Roman"
        End With
    End With
End Function

Function AutoColor()
    ActiveDocument.Content.Font.Color = wdColorAutomatic
End Function

Function Xbs()
'������Ϊ����С���μ���, Ĭ�ϲ�����
    With ActiveDocument
        With .Paragraphs(2).Range
            Do While .Next(4, 1).Font.Size = 22
                .MoveEnd 4
            Loop
            With .Font
                .Name = "����С���μ���"
                .Bold = False
            End With
        End With
    End With
End Function










