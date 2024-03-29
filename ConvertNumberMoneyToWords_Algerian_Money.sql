CREATE FUNCTION [dbo].[NombreEnLettres]
										(
											@nombre float 
										)
										RETURNS varchar(200)
										AS
										BEGIN
											DECLARE @lettres varchar(200)
											DECLARE @decimal varchar(200)
											DECLARE @diviseur int
											DECLARE @centaine int
											DECLARE @dizaine int
											DECLARE @unite int
											DECLARE @reste int
											DECLARE @resteDecimal decimal
											DECLARE @courant int
											DECLARE @dix bit
											DECLARE @et bit
											DECLARE @ajout varchar(200)
											DECLARE @entier int 
											DECLARE @ajout_decimal varchar(200)
											SET @entier = Convert(int,@nombre)
											SET @lettres = ''
											SET @diviseur = 1000000
											SET @dix = 0
											SET @reste = @nombre
											SET @resteDecimal =(@nombre-@entier)*100
											SET @decimal= Convert(varchar,(@nombre-@entier)*100)

											WHILE @diviseur >= 1
													BEGIN
														SELECT @courant = @reste / @diviseur
														IF @courant <> 0
														BEGIN
															SELECT @centaine = @courant / 100
															SELECT @dizaine = (@courant - @centaine * 100) / 10
															SELECT @unite = @courant - (@centaine * 100) - (@dizaine * 10)
															Select @resteDecimal =(@nombre-@entier)*100
															SELECT @ajout = ''

															SELECT @ajout = @ajout +
																CASE @centaine
																WHEN 1 THEN 'cent '
																WHEN 2 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'deux cents ' ELSE 'deux cent ' END
																WHEN 3 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'trois cents ' ELSE 'trois cent ' END
																WHEN 4 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'quatre cents ' ELSE 'quatre cent ' END
																WHEN 5 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'cinq cents ' ELSE 'cinq cent ' END
																WHEN 6 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'six cents ' ELSE 'six cent ' END
																WHEN 7 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'sept cents ' ELSE 'sept cent ' END
																WHEN 8 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'huit cents ' ELSE 'huit cent ' END
																WHEN 9 THEN 
																	CASE WHEN @dizaine = 0 AND @unite = 0 THEN 'neuf cents ' ELSE 'neuf cent ' END
																ELSE ''
														END
															SELECT @ajout = @ajout +
																CASE @dizaine
																WHEN 2 THEN 'vingt '
																WHEN 3 THEN 'trente '
																WHEN 4 THEN 'quarante '
																WHEN 5 THEN 'cinquante '
																WHEN 6 THEN 'soixante '
																WHEN 7 THEN 'soixante '
																WHEN 8 THEN 'quatre-vingt '
																WHEN 9 THEN 'quatre-vingt '
																ELSE ''
																END
															
															SELECT @dix = CASE @dizaine
																WHEN 1 THEN 1
																WHEN 7 THEN 1
																WHEN 9 THEN 1
																ELSE 0
																END

															SELECT @et = CASE @dizaine
																WHEN 0 THEN 0
																WHEN 1 THEN 0
																WHEN 2 THEN 1
																WHEN 3 THEN 1
																WHEN 4 THEN 1
																WHEN 5 THEN 1
																WHEN 6 THEN 1
																WHEN 7 THEN 1
																WHEN 8 THEN 0
																WHEN 9 THEN 0
																ELSE 0
																END

															SELECT @ajout = @ajout +
																CASE @unite
																WHEN 0 THEN
																	CASE @dix WHEN 1 THEN 'dix ' ELSE '' END
																WHEN 1 THEN
																	CASE @et WHEN 1 THEN 'et ' ELSE '' END +
																	CASE @dix WHEN 1 THEN 'onze ' ELSE 'un ' END
																WHEN 2 THEN
																	CASE @dix WHEN 1 THEN 'douze ' ELSE 'deux ' END
																WHEN 3 THEN
																	CASE @dix WHEN 1 THEN 'treize ' ELSE 'trois ' END
																WHEN 4 THEN
																	CASE @dix WHEN 1 THEN 'quatorze ' ELSE 'quatre ' END
																WHEN 5 THEN
																	CASE @dix WHEN 1 THEN 'quinze ' ELSE 'cinq ' END
																WHEN 6 THEN
																	CASE @dix WHEN 1 THEN 'seize ' ELSE 'six ' END
																WHEN 7 THEN
																	CASE @dix WHEN 1 THEN 'dix-sept ' ELSE 'sept ' END
																WHEN 8 THEN
																	CASE @dix WHEN 1 THEN 'dix-huit ' ELSE 'huit ' END
																WHEN 9 THEN
																	CASE @dix WHEN 1 THEN 'dix-neuf ' ELSE 'neuf ' END
																ELSE ''
																END
																
																Select @ajout_decimal = @ajout_decimal+
																Case @resteDecimal
																When 0 then 'Zero'
																When 1  then 'dix'
																When 10 then 'dix' 
																When 2 then 'vingt'
																When 20 then 'vingt'
																end

															SELECT @lettres = @lettres +	
																CASE @diviseur
																WHEN 1000000 THEN
																	CASE
																	WHEN @courant = 1 THEN 'un million ' 
																	WHEN @courant > 1 THEN @ajout + 'millions '
																	END 
																WHEN 1000 THEN
																	CASE WHEN @courant > 1 THEN @ajout ELSE '' END + 'mille '
																ELSE @ajout
																END
															SELECT @reste = @reste - @courant * @diviseur
														END
														SELECT @diviseur = @diviseur / 1000
														
											
											END
											IF @lettres = '' SELECT @lettres = 'zéro'
											IF @decimal = '' SELECT @decimal = 'zéro'
											IF @decimal = '1' SELECT @decimal = 'un'
											IF @decimal = '2' SELECT @decimal = 'deux'
											IF @decimal = '3' SELECT @decimal = 'trois'
											IF @decimal = '4' SELECT @decimal = 'quatre'
											IF @decimal = '5' SELECT @decimal = 'cinq'
											IF @decimal = '6' SELECT @decimal = 'six'
											IF @decimal = '7' SELECT @decimal = 'sept'
											IF @decimal = '8' SELECT @decimal = 'huit'
											IF @decimal = '9' SELECT @decimal = 'neuf'
											IF @decimal = '10' SELECT @decimal = 'dix'
											IF @decimal = '11' SELECT @decimal = 'onze'
											IF @decimal = '12' SELECT @decimal = 'douze'
											IF @decimal = '13' SELECT @decimal = 'tréze'
											IF @decimal = '14' SELECT @decimal = 'quatorze'
											IF @decimal = '15' SELECT @decimal = 'quinze'
											IF @decimal = '16' SELECT @decimal = 'seize'
											IF @decimal = '17' SELECT @decimal = 'dix-sept'
											IF @decimal = '18' SELECT @decimal = 'dix-huit'
											IF @decimal = '19' SELECT @decimal = 'dix-neuf'
											IF @decimal = '20' SELECT @decimal = 'vingt'
											IF @decimal = '21' SELECT @decimal = 'vingt et un'
											IF @decimal = '22' SELECT @decimal = 'vingt-deux'
											IF @decimal = '23' SELECT @decimal = 'vingt-trois'
											IF @decimal = '24' SELECT @decimal = 'vingt-quatre'
											IF @decimal = '25' SELECT @decimal = 'vingt-cinq'
											IF @decimal = '26' SELECT @decimal = 'vingt-six'
											IF @decimal = '27' SELECT @decimal = 'vingt-sept'
											IF @decimal = '28' SELECT @decimal = 'vingt-huit'
											IF @decimal = '29' SELECT @decimal = 'vingt-neuf'
											IF @decimal = '30' SELECT @decimal = 'trente'
											IF @decimal = '31' SELECT @decimal = 'trente et un'
											IF @decimal = '32' SELECT @decimal = 'trente-deux'
											IF @decimal = '33' SELECT @decimal = 'trente-trois'
											IF @decimal = '34' SELECT @decimal = 'trente-quatre'
											IF @decimal = '35' SELECT @decimal = 'trente-cinq'
											IF @decimal = '36' SELECT @decimal = 'trente-six'
											IF @decimal = '37' SELECT @decimal = 'trente-sept'
											IF @decimal = '38' SELECT @decimal = 'trente-huit'
											IF @decimal = '39' SELECT @decimal = 'trente-neuf'
											IF @decimal = '40' SELECT @decimal = 'quarante' 
											IF @decimal = '41' SELECT @decimal = 'quarante et un'
											IF @decimal = '42' SELECT @decimal = 'quarante-deux'
											IF @decimal = '43' SELECT @decimal = 'quarante-trois'
											IF @decimal = '44' SELECT @decimal = 'quarante-quatre'
											IF @decimal = '45' SELECT @decimal = 'quarante-cinq'
											IF @decimal = '46' SELECT @decimal = 'quarante-six'
											IF @decimal = '47' SELECT @decimal = 'quarante-sept'
											IF @decimal = '48' SELECT @decimal = 'quarante-huit'
											IF @decimal = '49' SELECT @decimal = 'quarante-neuf'
											IF @decimal = '50' SELECT @decimal = 'cinquante'
											IF @decimal = '51' SELECT @decimal = 'cinquante et un'
											IF @decimal = '52' SELECT @decimal = 'cinquante-deux'
											IF @decimal = '53' SELECT @decimal = 'cinquante-trois'
											IF @decimal = '54' SELECT @decimal = 'cinquante-quatre'
											IF @decimal = '55' SELECT @decimal = 'cinquante-cinq'
											IF @decimal = '56' SELECT @decimal = 'cinquante-six'
											IF @decimal = '57' SELECT @decimal = 'cinquante-sept'
											IF @decimal = '58' SELECT @decimal = 'cinquante-huit'
											IF @decimal = '59' SELECT @decimal = 'cinquante-neuf'
											IF @decimal = '60' SELECT @decimal = 'soixante'
											IF @decimal = '61' SELECT @decimal = 'soixante et un'
											IF @decimal = '62' SELECT @decimal = 'soixante-deux'
											IF @decimal = '63' SELECT @decimal = 'soixante-trois'
											IF @decimal = '64' SELECT @decimal = 'soixante-quatre'
											IF @decimal = '65' SELECT @decimal = 'soixante-cinq'
											IF @decimal = '66' SELECT @decimal = 'soixante-six'
											IF @decimal = '67' SELECT @decimal = 'soixante-sept'
											IF @decimal = '68' SELECT @decimal = 'soixante-huit'
											IF @decimal = '69' SELECT @decimal = 'soixante-neuf'
											IF @decimal = '70' SELECT @decimal = 'soixante-dix'
											IF @decimal = '71' SELECT @decimal = 'soixante et onze'
											IF @decimal = '72' SELECT @decimal = 'soixante-douze'
											IF @decimal = '73' SELECT @decimal = 'soixante-tréze'
											IF @decimal = '74' SELECT @decimal = 'soixante-quatorze'
											IF @decimal = '75' SELECT @decimal = 'soixante-quinze'
											IF @decimal = '76' SELECT @decimal = 'soixante-seize'
											IF @decimal = '77' SELECT @decimal = 'soixante-dix-sept'
											IF @decimal = '78' SELECT @decimal = 'soixante-dix-huit'
											IF @decimal = '79' SELECT @decimal = 'soixante-dix-neuf'
											IF @decimal = '80' SELECT @decimal = 'quatre-vingts'
											IF @decimal = '81' SELECT @decimal = 'quatre-vingt-un'
											IF @decimal = '82' SELECT @decimal = 'quatre-vingt-deux'
											IF @decimal = '83' SELECT @decimal = 'quatre-vingt-trois'
											IF @decimal = '84' SELECT @decimal = 'quatre-vingt-quatre'
											IF @decimal = '85' SELECT @decimal = 'quatre-vingt-cinq'
											IF @decimal = '86' SELECT @decimal = 'quatre-vingt-six'
											IF @decimal = '87' SELECT @decimal = 'quatre-vingt-sept'
											IF @decimal = '88' SELECT @decimal = 'quatre-vingt-huit'
											IF @decimal = '89' SELECT @decimal = 'quatre-vingt-neuf'
											IF @decimal = '90' SELECT @decimal = 'quatre-vingt-dix'
											IF @decimal = '91' SELECT @decimal = 'quatre-vingt-onze'
											IF @decimal = '92' SELECT @decimal = 'quatre-vingt-douze'
											IF @decimal = '93' SELECT @decimal = 'quatre-vingt-tréze'
											IF @decimal = '94' SELECT @decimal = 'quatre-vingt-quatorze'
											IF @decimal = '95' SELECT @decimal = 'quatre-vingt-quinze'
											IF @decimal = '96' SELECT @decimal = 'quatre-vingt-seize'
											IF @decimal = '97' SELECT @decimal = 'quatre-vingt-dix-sept'
											IF @decimal = '98' SELECT @decimal = 'quatre-vingt-dix-huit'
											IF @decimal = '99' SELECT @decimal = 'quatre-vingt-dix-neuf'
											RETURN RTRIM(@lettres)+' dinars algériens et ' +(@decimal)+' cts'
										END
										
										


