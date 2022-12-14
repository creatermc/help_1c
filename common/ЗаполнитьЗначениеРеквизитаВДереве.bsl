// Сохраняет значение в дереве данных.
//
// Параметры:
//  Дерево - ДеревоЗначений - дерево, содержащее данные электронного документа
//                            (см. ЭлектронноеВзаимодействие.ДеревоЭлектронногоДокумента).
//  Реквизит - Строка - содержит полный путь к реквизиту дерева.
//  Значение - Произвольный - сохраняемое в дереве значение.
//  ПараметрыОбработкиОшибок - Строка - используется, чтобы переопределить текст выводимой по реквизиту ошибки
//                                      без указания параметров действий по клику на ошибке.
//                           - Структура - используется для указания указания параметров действий по клику на ошибке,
//                                         формируется функцией ЭлектронноеВзаимодействиеКлиентСервер.НовыеПараметрыОбработкиОшибки.
//
Процедура ЗаполнитьЗначениеРеквизитаВДереве(Дерево, Реквизит, Значение, ПараметрыОбработкиОшибок = Неопределено) Экспорт
	
	// Заполним значение в нужной строке дерева.
	СтрокаДерева = Дерево.Строки.Найти(Реквизит, "ПолныйПуть", Истина);
	Если СтрокаДерева = Неопределено Тогда
		ТекстОшибки = СтрШаблон(НСтр("ru = 'Ошибка заполнения дерева данных. Не найден реквизит ""%1""';
									|en = 'An error occurred when filling in data tree. The ""%1"" attribute was not found'"), Реквизит);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	// Заполним параметры обработки ошибок.
	ДеревоЭлектронногоДокументаБЭДСлужебный.ЗаполнитьПараметрыОбработкиОшибокВСтрокеДерева(СтрокаДерева, ПараметрыОбработкиОшибок);
	
	СтрокаДерева.Значение = Значение;
	Если СтрокаДерева.Признак = "Группа" ИЛИ СтрокаДерева.Признак = "Выбор" Тогда
		Возврат;
	КонецЕсли;
	
	// Проставим значения в строках-родителях. При этом, если передана строка дерева, а не его корень, нужно пропустить
	// элементы пути вплоть до переданной строки.
	ПриведенныйПуть = Реквизит;
	Путь = "";
	Если ТипЗнч(Дерево) = Тип("СтрокаДереваЗначений") Тогда
		ПриведенныйПуть = Сред(Реквизит, СтрДлина(Дерево.ПолныйПуть) + 2);
		Путь = Путь + Дерево.ПолныйПуть;
	КонецЕсли;
	МассивРеквизитов = ОбщегоНазначенияКлиентСервер.РазложитьСтрокуПоТочкамИСлэшам(ПриведенныйПуть);
	Если МассивРеквизитов.Количество() = 1 Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Элемент Из МассивРеквизитов Цикл
		Путь = ?(ЗначениеЗаполнено(Путь), Путь + "." + Элемент, Элемент);
		СтрокаДерева = Дерево.Строки.Найти(Путь, "ПолныйПуть", Истина);
		Если СтрокаДерева.Признак =  "Группа" Тогда
			СтрокаДерева.Значение = Истина;
		ИначеЕсли СтрокаДерева.Признак = "Выбор" Тогда
			ТекИндекс = МассивРеквизитов.Найти(Элемент);
			СтрокаДерева.Значение = МассивРеквизитов[ТекИндекс+1];
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры
