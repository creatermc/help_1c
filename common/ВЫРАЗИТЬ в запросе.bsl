	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
	"ОбъектыРасчетов.Организация,", 
     "ОбъектыРасчетов.Организация,
	 |ВЫБОР
     |КОГДА ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаказКлиента
     |	ТОГДА ОбъектыРасчетов.Объект.НомерЗаявки
     |КОГДА ОбъектыРасчетов.Объект ССЫЛКА Документ.АктВыполненныхРабот
     |	ТОГДА ВЫБОР
     |			КОГДА ВЫРАЗИТЬ(ОбъектыРасчетов.Объект КАК Документ.АктВыполненныхРабот).ЗаказКлиента ССЫЛКА Документ.ЗаказКлиента
     |				ТОГДА ВЫРАЗИТЬ(ОбъектыРасчетов.Объект КАК Документ.АктВыполненныхРабот).ЗаказКлиента.НомерЗаявки
     |			ИНАЧЕ """"
     |		КОНЕЦ											 
	 |КОГДА ОбъектыРасчетов.Объект ССЫЛКА Документ.ЗаказПоставщику
     |	ТОГДА ОбъектыРасчетов.Объект.НомерЗаказа
     |КОГДА ОбъектыРасчетов.Объект ССЫЛКА Документ.ПриобретениеТоваровУслуг
     |	ТОГДА ВЫБОР
     |			КОГДА ВЫРАЗИТЬ(ОбъектыРасчетов.Объект КАК Документ.ПриобретениеТоваровУслуг).ЗаказПоставщику ССЫЛКА Документ.ЗаказПоставщику
     |				ТОГДА ВЫРАЗИТЬ(ОбъектыРасчетов.Объект КАК Документ.ПриобретениеТоваровУслуг).ЗаказПоставщику.НомерЗаказа
     |			ИНАЧЕ """"
     |		КОНЕЦ
     |ИНАЧЕ """"
     |КОНЕЦ КАК НомерЗаявки,
 	 |");
