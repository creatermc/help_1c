// Очищает значение в дереве данных.
//
// Параметры:
//  Дерево - ДеревоЗначений - дерево, содержащее данные электронного документа
//                            (см. ЭлектронноеВзаимодействие.ДеревоЭлектронногоДокумента).
//  Реквизит - Строка - содержит полный путь к реквизиту дерева.
//  ПараметрыОбработкиОшибок - Строка - используется, чтобы переопределить текст выводимой по реквизиту ошибки
//                                      без указания параметров действий по клику на ошибке.
//                           - Структура - используется для указания указания параметров действий по клику на ошибке,
//                                         формируется функцией ЭлектронноеВзаимодействиеКлиентСервер.НовыеПараметрыОбработкиОшибки.
//
Процедура ОчиститьЗначениеВСтрокеДерева(Дерево, Реквизит, ПараметрыОбработкиОшибок = Неопределено) Экспорт

	СтрокаДерева = Дерево.Строки.Найти(Реквизит, "ПолныйПуть", Истина);
	Если СтрокаДерева = Неопределено Тогда
		ТекстОшибки = СтрШаблон(НСтр("ru = 'Ошибка очистки реквизита дерева данных. Не найден реквизит ""%1""';
									|en = 'An error occurred when clearing the attribute of the data tree. The ""%1"" attribute was not found'"), Реквизит);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	// Заполним параметры обработки ошибок.
	ДеревоЭлектронногоДокументаБЭДСлужебный.ЗаполнитьПараметрыОбработкиОшибокВСтрокеДерева(СтрокаДерева, ПараметрыОбработкиОшибок);
	
	ТипЗначенияСтроки = СтрокаДерева.ТипЗначения;
	Если Не ТипЗнч(ТипЗначенияСтроки) = Тип("ОписаниеТипов") Тогда
		ТипЗначенияСтроки = Новый ОписаниеТипов();
	КонецЕсли;
	СтрокаДерева.Значение = ТипЗначенияСтроки.ПривестиЗначение();

КонецПроцедуры
