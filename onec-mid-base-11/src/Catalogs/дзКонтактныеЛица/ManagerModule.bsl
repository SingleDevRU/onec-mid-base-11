#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Поля.Добавить("Наименование");
	Поля.Добавить("ДействуетНаОсновании");

КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

		
	Если ЗначениеЗаполнено(Данные.ДействуетНаОсновании) Тогда
		
		СтандартнаяОбработка = Ложь;

		Представление = СтрШаблон("%1 (на осн. %2)",Данные.Наименование,Данные.ДействуетНаОсновании);

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
