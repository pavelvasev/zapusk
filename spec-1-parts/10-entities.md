Zapusk Спецификация 1
=====================

Запуск-программа
================
Запуск-программа это программа, предназначенная для того, чтобы привести машину в требуемое состояние.
В широком смысле цель запуск-программы - производить реакцию на те или иные команды, поступающие к ней.
Одной из реакций может быть настройка машины, но возможны и другие по смыслу реакции.

Программа реагирует на различные команды, включая две особые:
* `apply` -- достичь цели
* `destroy` -- отменить внесенные изменения.

Программа состоит из следующих частей:

1. Набор параметров и их значений.
Значения параметров могут быть переназначены при запуске программы.
Также при запуске могут быть добавлены новые параметры и их значения.

2. Набор компонент.
Каждый компонент имеет уникальный идентификатор. 
Порядок компонент важен.

3. Каждый компонент содержит набор шагов.
Каждый шаг имеет набор параметров и их значений, включая идентификатор и тип шага. 
Порядок шагов важен.

Программа выполняется интепретатором.

