BEGIN
	BEGIN TRY
		DECLARE @IDSpeciality INT
		DECLARE @Speciality VARCHAR(MAX)
		DECLARE @Specialitys CURSOR
		SET @Specialitys = CURSOR SCROLL
			FOR SELECT ID, [Name] FROM [UGTU].[FIS].[SpecDetailDictionary]
						WHERE ID NOT IN (17491, 16998, 17599, 17411, 17152, 17512, 13929, 16999 )
						ORDER BY [Name]
						
		DECLARE @IDCampaign INT
		DECLARE @IDDirection INT
		DECLARE @Direction VARCHAR(MAX)
		DECLARE @Directions CURSOR 
		SET @Directions = CURSOR SCROLL
			FOR SELECT [id],[Name], IIF(id = 52242, 2,
										IIF(id = 52243, 3, 1)) Campaign FROM [FIS].[DictionaryContent] WHERE DictionaryCode = 2 AND [id] <> 52244
		
		DECLARE @IDForm INT
		DECLARE @Form VARCHAR(MAX)
		DECLARE @FormEducations CURSOR
		SET @FormEducations = CURSOR SCROLL 
			FOR SELECT 57153 [id], 'Очная' [form]
				UNION SELECT 57154 [id], 'Очно-заочная' [form]
				UNION SELECT 57155 [id], 'Заочная' [form]
		
		DECLARE @IDSource INT
		DECLARE @Source VARCHAR(MAX)
		DECLARE @Finance CURSOR
		SET @Finance = CURSOR SCROLL 
			FOR SELECT [id],[Name] FROM [FIS].[DictionaryContent] WHERE DictionaryCode = 15

		OPEN @Specialitys	
		FETCH  NEXT FROM @Specialitys INTO @IDSpeciality, @Speciality
		WHILE @@FETCH_STATUS = 0
		BEGIN
			OPEN @Directions
			FETCH  NEXT FROM @Directions INTO @IDDirection, @Direction, @IDCampaign
			WHILE @@FETCH_STATUS = 0
			BEGIN
				OPEN @FormEducations
				FETCH  NEXT FROM @FormEducations INTO @IDForm, @Form
				WHILE @@FETCH_STATUS = 0
				BEGIN 
					OPEN @Finance
					FETCH  NEXT FROM @Finance INTO @IDSource, @Source
					WHILE @@FETCH_STATUS = 0
					BEGIN 
						INSERT [FIS].[CompetitiveGroup]  ([IDCampaign], [Name], [IDEduLevelFIS], [IDFormFIS], [IDEduSourceFIS], [IDSpecialityFIS]) 
						VALUES	(@IDCampaign, @Speciality + ' ' + @Form + ' ' + @Direction + ' ' + @Source, @IDDirection, @IDForm, @IDSource, @IDSpeciality)

						--SELECT @IDCampaign, @Speciality + ' ' + @Form + ' ' + @Direction + ' ' + @Source, @IDDirection, @IDForm, @IDSource, @IDSpeciality

						FETCH  NEXT FROM @Finance INTO @IDSource, @Source
					END
					CLOSE @Finance

					FETCH  NEXT FROM @FormEducations INTO @IDForm, @Form
				END
				CLOSE @FormEducations

				FETCH  NEXT FROM @Directions INTO @IDDirection, @Direction, @IDCampaign
			END
			CLOSE @Directions
			FETCH  NEXT FROM @Specialitys INTO @IDSpeciality, @Speciality
		END
		CLOSE @Specialitys
	END TRY
	BEGIN CATCH
		PRINT 'ERROR: ' + @Speciality
		SELECT  'ERROR: ' + @Speciality
				,ERROR_NUMBER() AS ErrorNumber  
				,ERROR_SEVERITY() AS ErrorSeverity  
				,ERROR_STATE() AS ErrorState  
				,ERROR_PROCEDURE() AS ErrorProcedure  
				,ERROR_LINE() AS ErrorLine  
				,ERROR_MESSAGE() AS ErrorMessage; 
	END CATCH
END;