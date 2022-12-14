пример из справочника Ключи реестра документов

&НаКлиенте
Процедура ДекорацияЕстьДублиВГлавномУзелРИБОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	УдалитьДубли();
КонецПроцедуры

&НаКлиенте
Процедура УдалитьДубли()
	
	ФоновоеЗадание = УдалитьДублиСервер();
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	Обработчик = Новый ОписаниеОповещения("ПослеУдаленияДублей", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, Обработчик, НастройкиОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеУдаленияДублей(ФоновоеЗадание, ДополнительныеПараметры) Экспорт
	
	Если ФоновоеЗадание <> Неопределено 
		И ФоновоеЗадание.Статус = "Выполнено" Тогда
	
		Если ЭтоАдресВременногоХранилища(ФоновоеЗадание.АдресРезультата) Тогда
			ПослеУдаленияДублейСервер(ФоновоеЗадание.АдресРезультата);
		КонецЕсли;
		
	Иначе
		Если ФоновоеЗадание <> Неопределено Тогда
			ОписаниеОшибки = НСтр("ru = 'Не удалось закончить выполнения задания по причине: %Причина%';
									|en = 'Cannot complete job. Reason: %Причина%'");
			ОписаниеОшибки = СтрЗаменить(ОписаниеОшибки, "%Причина%",  ФоновоеЗадание.ПодробноеПредставлениеОшибки);
			ПоказатьПредупреждение(, ОписаниеОшибки);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция УдалитьДублиСервер()
	
	ПараметрыВыполненияВФоне = ДлительныеОперации.ПараметрыВыполненияВФоне(ЭтотОбъект.УникальныйИдентификатор);
	ПараметрыВыполненияВФоне.НаименованиеФоновогоЗадания = НСтр("ru = 'Удаление дублей ключей реестра документов';
																|en = 'Delete duplicates of document registry keys'");
	ПараметрыВыполненияВФоне.ЗапуститьВФоне = Истина;
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне("Справочники.КлючиРеестраДокументов.НайтиИУдалитьДублиВФормеСписка",
		Новый Структура, ПараметрыВыполненияВФоне);
		
	ВремяНачалаИсправления = ТекущаяДатаСеанса();
		
	Возврат ФоновоеЗадание;
	
КонецФункции

модуль объекта
Процедура НайтиИУдалитьДублиВФормеСписка(Параметры, АдресВременногоХранилища) Экспорт
	
	Если Не ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Неопределено, "РегистрСведений.РеестрДокументов") Тогда
		ТекстИсключения = НСтр("ru = 'По реестру документов есть невыполненные обработчики обновления. Перед запуском процедуры необходимо дождаться окончания их выполнения.';
								|en = 'There are incomplete update handlers in the document registry. Before run the procedure, you need to wait until the end of their execution.'");
	    ВызватьИсключение ТекстИсключения;
	КонецЕсли;

	Результат = РезультатФоновыхЗаданий();
	
	НайтиИУдалитьДубли();
	
	Если ЕстьДубли() <> "Нет" Тогда
		Результат.ЕстьДубли = "Ошибка";
	Иначе
		Результат.ЕстьДубли = "Нет";
	КонецЕсли;	
	
	ПоместитьВоВременноеХранилище(Результат, АдресВременногоХранилища);
	
КонецПроцедуры


