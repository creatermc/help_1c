Свойство					Значение				Тип
НаборКонтактнойИнформации	ДанныеФормыКоллекция	ДанныеФормыКоллекция


	ТабКИ = ДанныеФормыВЗначение(НаборКонтактнойИнформации, Тип("ТаблицаЗначений"));
	
	ЗначениеВДанныеФормы(ТабКИ,НаборКонтактнойИнформации);	

Процедура КонтактнаяИнформацияПриСозданииНаСрвере(Ссылка,НаборКонтактнойИнформации)
	
	Набор = "";
	
	ИТ_УправлениеКонтактнойИнформацией.ПрочитатьКонтактнуюИнформацию(Набор, Ссылка);
	
	ТабКИ = ДанныеФормыВЗначение(НаборКонтактнойИнформации,Тип("ТаблицаЗначений"));
	ТабКИ.Очистить();
	тз = Набор.Выгрузить();
	Для каждого Стр Из тз Цикл
		
		НС = ТАбКИ.Добавить();
		ЗаполнитьЗначенияСвойств(НС,Стр);
		
	КонецЦикла;               		
	
	НастроитьНомераКартинок(ТабКИ);
	
	ЗначениеВДанныеФормы(ТабКИ,НаборКонтактнойИнформации);	
	
КонецПроцедуры
