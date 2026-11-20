# QBMenubar - Controlador nativo de qBittorrent para la barra de menús de macOS

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
  <b>Español</b> | 
  <a href="README_ru.md">Русский</a>
</p>

Una aplicación nativa de macOS ligera y de alto rendimiento construida con **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Diseñada con estilo **Liquid Glass** y animaciones de física **Apple Motion Feel** para monitorear y controlar tus descargas de qBittorrent directamente desde la barra de estado de tu Mac.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Vista previa de la barra de menús" width="650" />
</p>

---

## Capturas de pantalla

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Vista previa del panel popover" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Vista previa de configuración" width="480" />
</p>

---

## Características principales

1. **Elemento en la barra de menús**:
   - Velocidad de descarga y subida en tiempo real.
   - Porcentaje de descarga anclada directamente en la barra de estado (ej: `↓ 12.0 MB/s 85%`).
   - Ancho autoajustable sin recortes de texto.
2. **Panel popover Liquid Glass**:
   - Gráfico de ondas de ancho de banda en tiempo real (Swift Charts).
   - Barra de control rápido: Pausar todo, Reanudar todo, Velocidad alternativa (🐢), Abrir WebUI.
   - Pestañas de filtrado (Todos, Descargando, Sembrando, Pausados).
   - Botón **➕** para subir archivos `.torrent` con previsualización del contenido y selector de destino.
   - Detección automática de enlaces magnéticos en el portapapeles.
3. **Tarjetas de torrent interactivas**:
   - Insignias de estado, barra de progreso, tamaños, tiempo restante (ETA) y velocidades.
   - Árbol de archivos desplegable con iconos por tipo y progreso individual.
   - Botón chincheta (**📌**) para fijar una tarea en la barra de menús.
4. **Panel de ajustes al estilo macOS**:
   - Diseño limpio de dos columnas sin botones de colapso lateral.
   - Configuración completa de la API WebUI (local, NAS, VPS o proxy inverso).
   - Comprobador de conexión integrado con medición de Ping y versión.
   - Notificaciones nativas de macOS al finalizar descargas.

---

## Instalación y ejecución

### Opción 1: Descargar la aplicación compilada (Recomendado)
Descarga la aplicación lista para usar desde GitHub Releases:

👉 **[Descargar QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. Descarga y descomprime `QBMenubar-v1.0.0-macOS.zip`.
2. Mueve `QBMenubar.app` a tu carpeta `/Applications` (Aplicaciones).
3. ¡Haz doble clic en `QBMenubar.app` para iniciar!

> [!TIP]
> **Aviso de seguridad macOS Gatekeeper:**  
> Si macOS muestra una alerta indicando que no se puede verificar el desarrollador:  
> Haz **clic derecho (o Control + clic) sobre `QBMenubar.app`** en el Finder -> selecciona **Abrir** -> confirma haciendo clic en **Abrir**.  
> O ejecuta en la Terminal: `xattr -cr /Applications/QBMenubar.app`

### Opción 2: Compilar desde el código fuente
Requisitos: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## Licencia
Distribuido bajo la licencia [MIT License](LICENSE).
