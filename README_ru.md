# QBMenubar - Нативный контроллер qBittorrent для строки меню macOS

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <img src="https://img.shields.io/badge/Platform-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <b>Русский</b>
</p>

Легкое и быстрое нативное приложение для macOS, созданное на **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Сочетает в себе визуальный стиль **Liquid Glass** и пружинную физику анимаций **Apple Motion Feel** для удобного мониторинга и управления загрузками qBittorrent прямо из строки меню вашего Mac.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Предпросмотр строки меню" width="650" />
</p>

---

## Скриншоты интерфейса

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Всплывающая панель" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Окно настроек" width="480" />
</p>

---

## Основные возможности

1. **Элемент строки меню**:
   - Отображение скорости загрузки и отдачи в реальном времени.
   - Процент выполнения выбранной задачи прямо в статусной строке (например, `↓ 12.0 MB/s 85%`).
   - Динамическая подгонка ширины без обрезки текста.
2. **Панель Liquid Glass**:
   - Волновой график трафика в реальном времени (Swift Charts).
   - Быстрые действия: Пауза всех, Возобновить все, Альтернативная скорость (🐢), Открыть WebUI.
   - Вкладки фильтрации (Все, Загрузка, Раздача, На паузе).
   - Кнопка **➕** для загрузки файлов `.torrent` с предпросмотром списка файлов и выбором папки.
   - Автоматическое распознавание magnet-ссылок из буфера обмена.
3. **Интерактивные карточки раздач**:
   - Бейджи статуса, индикатор прогресса, размеры, расчетное время (ETA) и скорость.
   - Раскрывающийся список файлов с иконками типов файлов и индивидуальным прогрессом.
   - Кнопка закрепления (**📌**) для вывода прогресса раздачи в строку меню.
4. **Окно настроек в стиле Системных настроек macOS**:
   - Фиксированная двухколоночная структура без лишних кнопок сворачивания.
   - Полная настройка API WebUI (локально, NAS, VPS или обратный прокси).
   - Встроенный тест соединения (проверка Ping и версии сервера).
   - Системные уведомления macOS при завершении загрузок.

---

## Установка и запуск

### Способ 1: Скачать готовое приложение (Рекомендуется)
Скачайте готовое скомпилированное приложение прямо из GitHub Releases:

👉 **[Скачать QBMenubar (Latest) (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Скачайте и распакуйте `QBMenubar-*-macOS.zip`.
2. Переместите `QBMenubar.app` в папку `/Программы` (`/Applications`).
3. Запустите `QBMenubar.app` двойным кликом!

> [!TIP]
> **Предупреждение безопасности macOS Gatekeeper:**  
> Если macOS сообщает, что приложение не может быть открыто, так как разработчик не подтвержден:  
> Нажмите в Finder **правой кнопкой мыши (или Control + клик) на `QBMenubar.app`** -> выберите **Открыть** -> подтвердите открытие.  
> Либо выполните в Терминале: `xattr -cr /Applications/QBMenubar.app`

### Способ 2: Сборка из исходного кода
Требования: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## Лицензия
Распространяется под лицензией [MIT License](LICENSE).
