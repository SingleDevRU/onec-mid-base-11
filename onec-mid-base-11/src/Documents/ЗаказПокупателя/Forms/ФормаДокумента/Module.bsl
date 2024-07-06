
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти



#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	//++ Боярский Д.В, 06.07.2024 
	//Не пересчитываем сумму стандартным способом, пересчитываем с учетом процента скидки
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
	ПроцентСкидки = Объект.дзСогласованнаяСкидка + ТекущиеДанные.Скидка;
	
	Если ПроцентСкидки > 100 Тогда
	
		ПроцентСкидки = 100;
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Суммарная скидка не должна превышать 100%.";
		Сообщение.Сообщить();
	
	КонецЕсли;

	Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	Скидка = (Сумма * ПроцентСкидки) / 100; 
	
	ТекущиеДанные.Сумма = Сумма - Скидка;
	//--

	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьСуммуВСтрокахТаблицы(Таблица)	
	//++ Боярский Д.В. 06.07.2024	
	Для каждого СтрокаТаблицы Из Таблица Цикл
		РассчитатьСуммуСтроки(СтрокаТаблицы);		
	
	КонецЦикла;	
	//--
КонецПроцедуры 


&НаКлиенте
Асинх Процедура ЗадатьВопросПользователюАсинх()
	//++ Боярский Д.В. 06.07.2024  
	РежимДиалога = РежимДиалогаВопрос.ДаНет;
	ТекстВопроса = "Изменен процент скидки. Пересчитать таблицы товаров и услуг?";
	Ответ = Ждать ВопросАсинх(ТекстВопроса,РежимДиалога);
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
	
		Возврат;	
	
	КонецЕсли;
	
	ПересчитатьСуммуВСтрокахТаблицы(Объект.Товары);
	ПересчитатьСуммуВСтрокахТаблицы(Объект.Услуги);
	//--
	
КонецПроцедуры // ()

//++ Боярский Д.В. 06.07.2024

&НаКлиенте
Процедура дзСогласованнаяСкидкаПриИзменении(Элемент)
	//++ Боярский Д.В. 06.07.2024
	ТаблицыПустые = (Объект.Товары.Количество() = 0 И Объект.Услуги.Количество() = 0);
	
	Если ТаблицыПустые Тогда
	
		Возврат;	
	
	КонецЕсли;
	
	ЗадатьВопросПользователюАсинх();
	//--

КонецПроцедуры 

&НаКлиенте
Процедура ПересчитатьТаблицу(Команда)
	//++ Боярский Д.В. 06.07.2024
	// Пересчет суммы в строках таблицы по команде	
	ПересчитатьСуммуВСтрокахТаблицы(Объект.Товары);
	ПересчитатьСуммуВСтрокахТаблицы(Объект.Услуги);	
	//--

КонецПроцедуры 

//--

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
