# <b>Tasker</b><br>
<sup>Версия 0.12, сборка для дипломной сдачи: 9</sup>
### ✳︎ Идея и описание проекта:<br>
Приложение служит в качестве быстрых заметок и опирается на принцип отрывной записной книжки (записал -> выполнил -> выкинул). <b>Tasker?</b> - потому как в моем понимании задачник это достаточно точное определение этому приложению.<br>
<br>
В приложении использованы SF Symbols с анимацией и swipeActions на ячейках List. Для сохранения конфиденциальности используется блокировка по FaceID. Для каждой заметки доступен [предпроссмотр](https://developer.apple.com/documentation/swiftui/contextmenu) (удерживайте для вызова превью). Каждую заметку можно отметить как важную и поделиться ей (свайп меню или удержание заметки для вызова контектстного меню). Для всех заметок доступны drag&drop функции, а так же задействован [UIImpactFeedbackGenerator](https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator) (он же hapticEngine).<br>
<br>Полная история изменений с момента создания проекта доступна [тут](https://github.com/lepranby/Tasker-App/blob/main/Tasker/App/DiplomaReadme.md).
<br>
<br>
P.S. C момента создания проекта, в качестве источника информации использовался только документация от Apple и собственный конспект - чем, наверное, могу гордиться 🤓.
<br>

### ✳︎ Стек и функционал:<br>
Таргет: iOS 16 +<br>
SwiftUI<br>
UserDefaults<br>
LocalAuthentication<br>

### ✳︎ Локализация:<br>
Только русский.<br>
Планируемая локализация: английский, немецкий, украинский, польский, белорусский языки.<br>

### ✳︎ Скриншоты:<br>

<img width="325" height="595" alt="Screenshot 2023-08-02 at 11 12 10" src="https://github.com/lepranby/Tasker-App/assets/113884557/19e396fb-bca2-4cdb-8ec5-02007f5512a2">
<img width="325" height="595" alt="Screenshot 2023-08-02 at 10 21 34" src="https://github.com/lepranby/Tasker-App/assets/113884557/af770679-e79a-4d3f-a9ad-4f81d0087ed5">
<img width="325" height="595" alt="Screenshot 2023-08-02 at 11 12 48" src="https://github.com/lepranby/Tasker-App/assets/113884557/bc947f93-a920-4e1a-9e13-137f354fc905">
<img width="325" height="595" alt="Screenshot 2023-08-02 at 10 21 25" src="https://github.com/lepranby/Tasker-App/assets/113884557/19ec41ff-60d2-45fb-88aa-b9822980b949">
