# 🧰 JoannaEquipment (Экипировка Иоанны)

Учебный проект на Swift по мотивам детектива Иоанны Хмелевской «Что сказал покойник». Программа помогает разобраться в вещах героини перед скачками и распределяет их на полезные для побега и опасные, из-за которых её похитили.

## 🎯 Что я здесь тренирую
Главная цель — научиться мыслить логическими блоками и связывать разные элементы Swift в одну рабочую цепочку.

## 🛠️ Какие темы из шпаргалки здесь работают (Связка 1️⃣ + 4️⃣)
* **`enum`** 🏷️ — деление предметов по типам (`book`, `clothing`, `accessory`) вместо обычного текста.
* **`struct`** 📦 — модель предмета `Item` со свойствами и булевыми флагами (`isDangerous`, `isUseful`).
* **`computed property`** ⚙️ — вычисляемое свойство `info` со `switch-case` для красивой сборки строки с эмодзи.
* **Функции высшего порядка** 🔄 — последовательная обработка массива:
  1. `.filter` — отбор предметов по флагам.
  2. `.map` — вытаскивание готового текста `info` из каждого объекта.
  3. `.joined` — склеивание строк через перенос `\n` для аккуратного списка.

## 📊 Результат в консоли (Чистый вывод)

```text
EASY: 'Экипировка Иоанны'

⚠️ Because of them, Joanna was mistaken for Madeleine and kidnapped:
🧣 Accessory: A platinum wig and complementary makeup — Because of them, Joanna was mistaken for Madeleine

🧰 They will help Joanna escape the dungeons of Shannon Castle:
📚 Book: Geography Atlas of the World — A hefty, beautifully crafted atlas — a long-awaited dream
🧣 Accessory: A white acrylic scarf — A soft, fluffy white acrylic scarf
🧣 Accessory: Plastic crochet hook — A heavy-duty chunky plastic crochet hook
```
