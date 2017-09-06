USE [Kadr]
GO

INSERT INTO [ShemaTabel].[Exception]
           ([ExceptionName], [DateException], [idDayStatus], [idPrikaz], [KolHourMPS], [KolHourMNS], [KolHourGPS], [KolHourGNS], [idWorkShedule])
     VALUES --����� ��� + ��������� [idWorkShedule]=1
            ('����� ���', '2017-01-01'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-02'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-03'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-04'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-05'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-06'              , 17,        1,           0,              0,           0,            0,           1),
            ('���������', '2017-01-07'              , 17,        1,           0,              0,           0,            0,           1),
            ('����� ���', '2017-01-08'              , 17,        1,           0,              0,           0,            0,           1),
            -- [idWorkShedule] =2 
            ('����� ���', '2017-01-01'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-02'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-03'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-04'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-05'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-06'              , 17,        1,           0,              0,           0,            0,           2),
            ('���������', '2017-01-07'              , 17,        1,           0,              0,           0,            0,           2),
            ('����� ���', '2017-01-08'              , 17,        1,           0,              0,           0,            0,           2),
            -- ���
            ('���� ��������� ���������', '2017-02-23',17,        1,           0,              0,           0,            0,           1),
            ('���� ��������� ���������', '2017-02-23',17,        1,           0,              0,           0,            0,           2),
            --���
            ('������������� ������� ����', '2017-03-08',17,        1,           0,              0,           0,            0,           1),
            ('������������� ������� ����', '2017-03-08',17,        1,           0,              0,           0,            0,           2),
            --����������
            ('�������� ����� � �����', '2017-05-01'    ,17,        1,           0,              0,           0,            0,           1),
            ('�������� ����� � �����;', '2017-05-01'   ,17,        1,           0,              0,           0,            0,           2),
            --�������
            ('���� ������', '2017-05-09'               ,17,        1,           0,              0,           0,            0,           1),
            ('���� ������', '2017-05-09'               ,17,        1,           0,              0,           0,            0,           2),
            --��������
            ('���� ������', '2017-06-12'               ,17,        1,           0,              0,           0,            0,           1),
            ('���� ������', '2017-06-12'               ,17,        1,           0,              0,           0,            0,           2),
            --�����������
            ('���� ��������� ��������', '2017-11-04'   ,17,        1,           0,              0,           0,            0,           1),
            ('���� ��������� ��������', '2017-11-04'   ,17,        1,           0,              0,           0,            0,           2),
            --��������
            ('������� � 1 ������(��)', '2017-02-24'    ,17,        1,           0,              0,           0,            0,           1),
            ('������� � 1 ������(��)', '2017-02-24'    ,17,        1,           0,              0,           0,            0,           2),
            ('������� � 7 ������(��)', '2017-05-08'    ,17,        1,           0,              0,           0,            0,           1),
          --('������� � 7 ������(��)', '2017-05-08'    ,17,        1,           0,              0,           0,            0,           2), ���� ��?
            ('������� ��� � 4 ������(��)', '2017-11-06',17,        1,           0,              0,           0,            0,           1),
          --('������� � 4 ������(��)', '2017-11-06'    ,17,        1,           0,              0,           0,            0,           2), ���� ��?
            --��������������� ���
            ('��� � ��� ��������� ���������', '2017-02-22',22,        1,           0,              0,           0,            0,           1),
            ('��� � ��� ��������� ���������', '2017-02-22',22,        1,           0,              0,           0,            0,           2),
            ('��� � ���', '2017-03-07'                    ,22,        1,           0,              0,           0,            0,           1),
            ('��� � ���', '2017-03-07'                    ,22,        1,           0,              0,           0,            0,           2),
            ('��� � ��� ������', '2017-05-08'             ,22,        1,           0,              0,           0,            0,           2), --??
            ('��� � ��� ��������� ��������', '2017-11-03' ,22,        1,           0,              0,           0,            0,           1),
            ('��� � ��� ��������� ��������', '2017-11-03' ,22,        1,           0,              0,           0,            0,           2)
          -- (<ExceptionName, varchar(50),>,<DateException, date,>,<idDayStatus, int,> ,<idPrikaz, int,>,<KolHourMPS, real,>,<KolHourMNS, real,>,<KolHourGPS, real,>,<KolHourGNS, real,>,<idWorkShedule, int,>) 
          --idWorkShedule=1->5 
          --idWorkShedule=2->6 
          --idWorkShedule=3 ->~
          --idDayStatus=17 ->��������(7) � �����������
          --idDayStatus=22 ->���� ����������� ����
GO