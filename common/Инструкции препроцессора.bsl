Инструкции препроцессора
Для указания разрешения использования процедур и функций общих модулей и модулей объектов используют инструкции препроцессора.
Синтаксис:
Инструкция препроцессору
<Инструкция> = { Если <Логическое выражение> Тогда | ИначеЕсли <Логическое выражение> Тогда | Иначе | КонецЕсли | Вставка | КонецВставки | Удаление | КонецУдаления }
Логическое выражение
<Логическое выражение> = [НЕ] <Символ препроцессора> [<Булева операция> [НЕ] <Символ препроцессора> [<Булева операция> [НЕ] <Символ препроцессора>]…]
Символ препроцессора
<Символ препроцессора> = { Сервер | НаСервере | Клиент | НаКлиенте | ТонкийКлиент | МобильныйКлиент | ВебКлиент | ВнешнееСоединение | ТолстыйКлиентУправляемоеПриложение | ТолстыйКлиентОбычноеПриложение | МобильныйАвтономныйСервер | МобильноеПриложениеКлиент | МобильноеПриложениеСервер | Область | КонецОбласти }
Булева операция
<Булева операция> = {И | Или}
Используемые термы:
#Если (#If)
#Тогда (#Then)
#ИначеЕсли (#ElsIf)
#Иначе (#Else)
#КонецЕсли (#EndIf)
#Область (#Region)
#КонецОбласти (#EndRegion)
#Вставка (#Insert)
#КонецВставки (#EndInsert)
#Удаление (#Delete)
#КонецУдаления (#EndDelete)
И (AND)
ИЛИ (OR)
НЕ (NOT)
Клиент (Client)
НаКлиенте (AtClient)
НаСервере (AtServer)
Сервер (Server)
ТонкийКлиент (ThinClient)
ВебКлиент (WebClient)
МобильныйАвтономныйСервер (MobileStandaloneServer)
МобильноеПриложениеКлиент (MobileAppClient)
МобильноеПриложениеСервер (MobileAppServer)
МобильныйКлиент (MobileClient)
ТолстыйКлиентОбычноеПриложение(ThickClientOrdinaryApplication)
ТолстыйКлиентУправляемоеПриложение (ThickClientManagedApplication)
ВнешнееСоединение (ExternalConnection)
Регистр букв (строчные или заглавные) при написании не имеет значения.
Описание использования:

Группировка и свертка групп строк в модулях на встроенном языке

#Область [<Имя области>]
…
#КонецОбласти
[<Имя области>] – это идентификатор, который будет использоваться для отображения заголовка области, когда область свернута.
Если <Имя области> отсутствует, не является идентификатором или состоит из нескольких идентификаторов, будет выдаваться синтаксическая ошибка.
При редактировании модуля, в случае, если имя области не указано, при отображении свернутой области будет использована не локализуемая строка вида "[.....]".
Эти инструкции препроцессора ни на что не влияют. При формировании клиентской части модулей в управляемом приложении, инструкции вырезаются из формируемого клиентского модуля и, соответственно, в клиентское приложение не передаются.
Инструкции препроцессора #Область и #КонецОбласти должны быть парными. Они не могут пересекаться с другими инструкциями препроцессора. 
Такой код вызовет ошибки компиляции модуля.
#Область Обл1
…
#Если Клиент Тогда
…
#КонецОбласти
…
#КонецЕсли
Инструкции препроцессора #Область и #КонецОбласти могут быть вложенными, т.е. обозначать области, вложенные друг в друга:
#Область Обл1
…
#Область Обл2
…
…
#КонецОбласти
…
#КонецОбласти
Поскольку единственное назначение инструкций препроцессора #Область и #КонецОбласти состоит в обозначении группируемых или группируемых и сворачиваемых строк в модулях на встроенном языке, не поддерживается пересечение этих инструкций с другими группируемыми конструкциями встроенного языка, например, с процедурами/функциями, условными операторами, циклами.
Правильно:
#Область Обл1
…
Процедура Проц1()
…
КонецПроцедуры
…
#КонецОбласти
Неправильно (группируемые части модуля пересекаются):
#Область Обл1
…
Процедура Проц1()
…
#КонецОбласти
…
КонецПроцедуры
Инструкции препроцессора в различных вариантах работы

При описании того, какие инструкции препроцессора определены в различных вариантах работы, будем считать, что:
Клиентская часть - это приложение системы "1С:Предприятие", которое работает на компьютере пользователя.
Серверная часть - это приложение системы "1С:Предприятие", которое работает на компьютере, на котором работает кластер серверов системы "1С:Предприятие".
В различных вариантах использования определены различные наборы инструкций препроцессора:
Файловый вариант:
Тонкий клиент:
Клиентская часть: Клиент, НаКлиенте, ТонкийКлиент.
Серверная часть: Сервер, НаСервере.
Веб-клиент:
Клиентская часть: Клиент, НаКлиенте, ВебКлиент.
Серверная часть: Сервер, НаСервере.
Внешнее соединение:
Клиентская часть: недоступно,
Серверная часть: Сервер, НаСервере,ВнешнееСоединение.
Интернет-сервисы, фоновые и регламентные задания:
Клиентская часть: недоступно.
Серверная часть: Сервер, НаСервере.
Толстый клиент в управляемом режиме:
Клиентская часть: Сервер, НаСервере, Клиент, НаКлиенте, ТолстыйКлиентУправляемоеПриложение.
Серверная часть: Сервер, НаСервере, Клиент, НаКлиенте, ТолстыйКлиентУправляемоеПриложение.
Толстый клиент в обычном режиме:
Клиентская часть: Сервер, НаСервере, Клиент, НаКлиенте, ТолстыйКлиентОбычноеПриложение.
Серверная часть: Сервер, НаСервере, Клиент, НаКлиенте, ТолстыйКлиентОбычноеПриложение.
Клиент-серверный вариант:
Тонкий клиент:
Клиентская часть: Клиент, НаКлиенте, ТонкийКлиент.
Серверная часть: Сервер, НаСервере.
Веб-клиент:
Клиентская часть: Клиент, НаКлиенте, ВебКлиент.
Серверная часть: Сервер, НаСервере.
Мобильный клиент:
Клиентская часть: Клиент, НаКлиенте, МобильныйКлиент.
Серверная часть: Сервер, НаСервере.
Мобильный клиент с автономным режимом:
Клиентская часть: Клиент, НаКлиенте, МобильныйКлиент.
Серверная часть: Сервер, НаСервере.
Серверная часть на мобильном устройстве: Сервер, НаСервере, МобильныйАвтономныйСервер.
Внешнее соединение:
Клиентская часть: недоступно.
Серверная часть: ВнешнееСоединение.
Интернет-сервисы, фоновые и регламентные задания:
Клиентская часть: недоступно.
Серверная часть: Сервер, НаСервере.
Толстый клиент в управляемом режиме:
Клиентская часть: Клиент, НаКлиенте, ТолстыйКлиентУправляемоеПриложение.
Серверная часть: Сервер, НаСервере.
Толстый клиент в обычном режиме:
Клиентская часть: Клиент, НаКлиенте, ТолстыйКлиентОбычноеПриложение.
Серверная часть: Сервер, НаСервере.
Мобильная платформа:
Клиентская часть: Клиент, НаКлиенте, МобильноеПриложениеКлиент.
Серверная часть: Сервер, НаСервере, МобильноеПриложениеСервер.
Если используется неглобальный общий модуль, для которого установлено использование на клиенте (любом) и на сервере, то методы, заключенные в условие #Если Сервер Тогда #КонецЕсли, будут доступны только в том случае, если вызов этих методов выполняется со стороны сервера. Вызов таких методов со стороны клиента недоступен.
В остальных случаях инструкции Сервер и НаСервере полностью идентичны и инструкции Клиент и НаКлиенте также полностью идентичны.
Особенности использования инструкций препроцессора совместно с директивами компиляции см в главе "Директивы компиляции".
Точечная модификация метода в расширении (с аннотацией &ИзменениеИКонтроль)

В текст расширяемого метода можно внести точечные изменения. Для этого метод должен быть скопирован в расширение с аннотацией &ИзменениеИКонтроль. С помощью инструкций #Вставка … #КонецВставки и #Удаление … #КонецУдаления отмечаются фрагменты текста, которые необходимо добавить в расширяемый модуль и, соответственно, удалить из него.
     Методическая информация