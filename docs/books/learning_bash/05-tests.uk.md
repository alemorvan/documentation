---
title: Bash - Тести
author: Antoine Le Morvan
contributors: Steven Spencer, Ganna Zhyrnova
tested_with: 8.5
tags:
  - освіта
  - сценарій bash
  - bash
---

# Bash - Тести

****

**Цілі**: В цьому розділі ви дізнаєтеся як:

:heavy_check_mark: працювати з кодом повернення;  
:heavy_check_mark: перевірити та порівняти файли;  
:heavy_check_mark: перевірити змінні, рядки та цілі числа;  
:heavy_check_mark: виконати операцію з цілими числами;

:checkered_flag: **linux**, **сценарій**, **bash**, **змінна**

**Знання**: :star: :star:  
**Складність**: :star: :star: :star:

**Час для читання**: 10 хвилин

****

Після завершення всі команди, які виконує оболонка, повертають **код повернення** (також називається **статус** або **код виходу**).

* Якщо команда виконана правильно, код стану буде **нульовим**.
* Якщо під час виконання команди виникла проблема, її код стану матиме **ненульове значення**. На це є багато причин: відсутність прав доступу, відсутність файлу, неправильне введення тощо.

Вам слід звернутися до посібника з `команди man`, щоб дізнатися про різні значення коду повернення, наданого розробниками.

Код повернення не відображається безпосередньо, але зберігається в спеціальній змінній: `$?`.

```bash
mkdir directory
echo $?
0
```

```bash
mkdir /directory
mkdir: unable to create directory
echo $?
1
```

```bash
command_that_does_not_exist
command_that_does_not_exist: command not found
echo $?
127
```

!!! примітка

    Відображення вмісту змінної `$?` за допомогою команди `echo` виконується відразу після команди, яку ви хочете оцінити, оскільки ця змінна оновлюється після кожного виконання команди, командного рядка або сценарію.

!!! підказка

    Оскільки значення `$?` змінюється після кожного виконання команди, краще помістити його значення в змінну, яка буде використовуватися згодом, для перевірки або для відображення повідомлення.

    ```
    ls no_file
    ls: cannot access 'no_file': No such file or directory
    result=$?
    echo $?
    0
    echo $result
    2
    ```

Також можна створити коди повернення в сценарії. Для цього вам просто потрібно додати числовий аргумент до команди `exit`.

```bash
bash # to avoid being disconnected after the "exit 2
exit 123
echo $?
123
```

Крім правильного виконання команди, оболонка пропонує можливість запускати тести на багатьох шаблонах:

* **Файли**: існування, тип, права, порівняння;
* **Рядки**: довжина, порівняння;
* **Числові цілі числа**: значення, порівняння.

Результат тесту:

* `$?=0` : тест було виконано правильно та відповідає дійсності;
* `$?=1` : тест було виконано правильно та є помилковим;
* `$?=2`: тест виконано неправильно.

## Тестування типу файлу

Синтаксис команди `test` для файлу:

```bash
test [-d|-e|-f|-L] file
```

або:

```bash
[ -d|-e|-f|-L file ]
```

!!! note "ВАЖЛИВО"

    Зверніть увагу, що після `[` і перед `]` є пробіл.

Параметри команди перевірки файлів:

| Опція | Функціональність                                                        |
| ----- | ----------------------------------------------------------------------- |
| `-e`  | Перевіряє, чи існує файл                                                |
| `-f`  | Перевіряє, чи файл існує та має звичайний тип                           |
| `-d`  | Перевіряє, чи файл існує та має тип каталогу                            |
| `-L`  | Перевіряє, чи файл існує та має тип символічного посилання              |
| `-b`  | Перевіряє, чи існує файл і чи він у режимі блокування спеціального типу |
| `-c`  | Перевіряє, чи існує файл і чи він у режимі символів спеціального типу   |
| `-p`  | Перевіряє, чи файл існує та має тип named pipe (FIFO)                   |
| `-S`  | Перевіряє, чи файл існує та має тип socket                              |
| `-t`  | Перевіряє, чи файл існує та має типу terminal                           |
| `-r`  | Перевіряє, чи існує файл і чи його можна прочитати                      |
| `-w`  | Перевіряє, чи файл існує та доступний для запису                        |
| `-x`  | Перевіряє, чи файл існує та є виконуваним                               |
| `-g`  | Перевіряє, чи існує файл і чи має встановлений SGID                     |
| `-u`  | Перевіряє, чи існує файл і чи має встановлений SUID                     |
| `-s`  | Перевіряє, чи файл існує та чи він непорожній (розмір > 0 байтів)       |

Приклад:

```bash
test -e /etc/passwd
echo $?
0
[ -w /etc/passwd ]
echo $?
1
```

Було створено внутрішню команду для деяких оболонок (включаючи bash), яка є сучаснішою та надає більше можливостей, ніж зовнішня команда `test`.

```bash
[[ -s /etc/passwd ]]
echo $?
1
```

!!! ВАЖЛИВО

    Тому ми будемо використовувати внутрішню команду для решти цієї глави.

## Порівняння двох файлів

Також можна порівняти два файли:

```bash
[[ file1 -nt|-ot|-ef file2 ]]
```

| Опція | Функціональність                                          |
| ----- | --------------------------------------------------------- |
| `-nt` | Перевіряє, чи перший файл є новішим за другий             |
| `-ot` | Перевіряє, чи перший файл старший за другий               |
| `-ef` | Перевіряє, чи є перший файл фізичним посиланням на другий |

## Тестування змінних

Можна перевірити змінні:

```bash
[[ -z|-n $variable ]]
```

| Опція | Функціональність                |
| ----- | ------------------------------- |
| `-z`  | Перевіряє, чи порожня змінна    |
| `-n`  | Перевіряє, чи змінна не порожня |

## Тестування рядків

Також можна порівняти два рядки:

```bash
[[ string1 =|!=|<|> string2 ]]
```

Приклад:

```bash
[[ "$var" = "Rocky rocks!" ]]
echo $?
0
```

| Опція  | Функціональність                                                |
| ------ | --------------------------------------------------------------- |
| `=`    | Перевіряє, чи перший рядок дорівнює другому                     |
| `!=`   | Перевіряє, чи перший рядок відрізняється від другого            |
| `<` | Перевіряє, чи перший рядок передує другому в порядку ASCII      |
| `>` | Перевіряє, чи стоїть перший рядок після другого в порядку ASCII |

## Порівняння цілих чисел

Синтаксис для перевірки цілих чисел:

```bash
[[ "num1" -eq|-ne|-gt|-lt "num2" ]]
```

Приклад:

```bash
var=1
[[ "$var" -eq "1" ]]
echo $?
0
```

```bash
var=2
[[ "$var" -eq "1" ]]
echo $?
1
```

| Опція | Функціональність                                    |
| ----- | --------------------------------------------------- |
| `-eq` | Перевіряє, чи дорівнює перше число другому          |
| `-ne` | Перевіряє, чи відрізняється перше число від другого |
| `-gt` | Перевіряє, чи перше число більше за друге           |
| `-lt` | Перевіряє, чи перше число менше другого             |

!!! Примітка

    Оскільки числові значення обробляються оболонкою як звичайні символи (або рядки), перевірка символу може повернути той самий результат, незалежно від того, розглядається він як число чи ні.

    ```
    test "1" = "1"
    echo $?
    0
    test "1" -eq "1"
    echo $?
    0
    ```


    Але результат тесту матиме інше значення:

    * У першому випадку це означатиме, що два символи мають однакове значення в таблиці ASCII.
    * У другому випадку це означатиме, що два числа рівні.

## Комбіновані тести

Комбінація тестів дозволяє виконати кілька тестів в одній команді. Можна перевірити один і той самий аргумент (файл, рядок або число) кілька разів або різні аргументи.

```bash
[ option1 argument1 [-a|-o] option2 argument 2 ]
```

```bash
ls -lad /etc
drwxr-xr-x 142 root root 12288 sept. 20 09:25 /etc
[ -d /etc -a -x /etc ]
echo $?
0
```

| Опція | Функціональність                                               |
| ----- | -------------------------------------------------------------- |
| `-a`  | AND: Тест буде істинним, якщо всі шаблони істинні.             |
| `-o`  | OR: Тест буде істинним, якщо принаймні один шаблон є істинним. |

Для внутрішньої команди краще використовувати наступний синтаксис:

```bash
[[ -d "/etc" && -x "/etc" ]]
```

Тести можна згрупувати за допомогою дужок `(` `)`, щоб надати їм пріоритет.

```bash
(TEST1 -a TEST2) -a TEST3
```

Символ `!` використовується для виконання зворотної перевірки того, що запитує параметр:

```bash
test -e /file # true if file exists
! test -e /file # true if file does not exist
```

## Числові операції

Команда `expr` виконує операцію з числовими цілими числами.

```bash
expr num1 [+] [-] [\*] [/] [%] num2
```

Приклад:

```bash
expr 2 + 2
4
```

!!! warning "Увага"

    Будьте обережні, оточуйте знак операції пробілом. Якщо ви забудете, ви отримаєте повідомлення про помилку.
    У разі множення символу підстановки `*` передує `\`, щоб уникнути неправильній інтерпретації.

| Опція  | Функціональність    |
| ------ | ------------------- |
| `+`    | Додавання           |
| `-`    | Віднімання          |
| `\*` | Множення            |
| `/`    | Частка ділення      |
| `%`    | Залишок від ділення |

## Команда `typeset`

Команда `typeset -i` оголошує змінну як ціле число.

Приклад:

```bash
typeset -i var1
var1=1+1
var2=1+1
echo $var1
2
echo $var2
1+1
```

## Команда `let`

Команда `let` перевіряє, чи є символ числом.

Приклад:

```bash
var1="10"
var2="AA"
let $var1
echo $?
0
let $var2
echo $?
1
```

!!! Warning "Увага"

    Команда `let` не повертає послідовний код повернення, коли вона обчислює числове значення `0`.

    ```
    let 0
    echo $?
    1
    ```

Команда `let` також дозволяє виконувати математичні операції:

```bash
let var=5+5
echo $var
10
```

`let` можна замінити на `$(( ))`.

```bash
echo $((5+2))
7
echo $((5*2))
10
var=$((5*3))
echo $var
15
```
