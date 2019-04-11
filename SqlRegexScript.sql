Alter Function [RemoveSingleLetter](@Temp nvarChar(1000))
Returns NVarChar(1000)
AS
Begin

    Declare @NumRange as nvarchar(50) = '% [a-z] %' ---Pattern= b d g hgfh d removed b d g d
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp)+1, 1, '')

    
	--Pattern=!@#a removed a
	set @NumRange  = '%[^a-zA-z0-9][a-z]' 
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp)+1, 1, '')

    --Pattern=!@#a@#$ removed a
	set @NumRange  = '%[^a-zA-z0-9][a-z][^a-zA-z]%' 
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp)+1, 1, '')

	--Pattern=a!
	set @NumRange  = '%[^a-zA-z0-9][a-z][^a-zA-z0-9]' 
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')

	--Pattern=p @#$% removed a
	set @NumRange  = '[a-z][^a-zA-z]%' 
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')


    --Pattern=dj a!@#$% removed a
	set @NumRange  = '%[a-z][^a-zA-z]' 
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')

	----Pattern=abc #$a removed a
	--set @NumRange  = '%[a-z][^a-zA-z]' 
 --   While PatIndex(@NumRange, @Temp) > 0
 --       Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '')

    Return @Temp
End

go

--Select dbo.RemoveSingleLetter('!#$%!a b!bcd d -a- e fg g h dg!a@#$')Tested
--Select dbo.RemoveSingleLetter('!!@!a bd df g!!!!c')Tested
--Select dbo.RemoveSingleLetter('d g%%%')Tested
