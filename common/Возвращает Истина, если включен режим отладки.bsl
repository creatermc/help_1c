
общий модуль ОбщегоНазначения 


// Возвращает Истина, если включен режим отладки.
//
// Возвращаемое значение:
//  Булево - Истина, если включен режим отладки.
//
Функция РежимОтладки() Экспорт
	
	ПараметрЗапускаПриложения = ПараметрыСеанса.ПараметрыКлиентаНаСервере.Получить("ПараметрЗапуска");
	Возврат СтрНайти(ПараметрЗапускаПриложения, "РежимОтладки") > 0;
	
КонецФункции
