# QBMenubar - Controlador nativo de qBittorrent para la barra de menús de macOS

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Controlador nativo de qBittorrent para la barra de menús de macOS con diseño Liquid Glass" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Descargas"></a>
  <img src="https://img.shields.io/badge/Plataforma-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/Arquitectura-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/Licencia-MIT-green" alt="MIT License">
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

**QBMenubar** es una aplicación nativa para macOS, ligera y ultrarrápida para **qBittorrent**, creada con **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Combina la estética translúcida de **Liquid Glass** y la física de muelles de **Apple Motion Feel** para ofrecer control total y monitorización de velocidad en tiempo real de tus descargas con un impacto mínimo en el sistema (CPU < 0,1 %, RAM ~40 MB).

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Indicador de velocidad y porcentaje anclado en la barra de menús" width="650" />
</p>

---

## 🎯 Casos de uso clave (Use Cases)

- 🚀 **Control local y NAS remoto**: Monitoriza qBittorrent ya sea en tu Mac local, NAS Synology, QNAP, Unraid, TrueNAS, contenedores Docker o VPS remotos mediante IP de red local, dominio o proxy inverso HTTPS.
- 📌 **Fijar progreso en la barra de menús**: Ancla con un solo clic el porcentaje de descarga de un torrent prioritario directamente junto al reloj de tu Mac (ej.: `↓ 12.0 MB/s 85%`).
- ⚡️ **Cero impacto en batería y rendimiento**: A diferencia de las pesadas aplicaciones Electron o pestañas de navegador abiertas, esta app nativa Swift 6 consume 0,0 % de CPU en reposo y entre 35 y 45 MB de RAM.
- 🐢 **Acciones rápidas en un clic**: Pausa y reanuda todos los torrents al instante, o activa la velocidad alternativa (🐢 modo tortuga) durante videollamadas o juegos.
- 📋 **Detección inteligente de enlaces magnéticos**: Reconocimiento automático de enlaces `magnet:` en el portapapeles e inspección de archivos `.torrent` antes de la descarga.

---

## 📸 Capturas de pantalla & Demostración

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Panel flotante Liquid Glass de QBMenubar" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Ventana de preferencias estilo Ajustes del Sistema de macOS" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="Ajustes de widgets y permisos de privacidad en macOS" width="580" />
</p>

---

## 📊 Comparativa: ¿Por qué QBMenubar?

| Característica | QBMenubar (Nativo) | WebUI Navegador | Cliente Qt Oficial | Scripts Python / SwiftBar |
|---|:---:|:---:|:---:|:---:|
| **Barra de menús nativa** | ✅ Nativo Liquid Glass | ❌ Solo navegador | ❌ Solo Dock / Ventana | ⚠️ Solo menú de texto |
| **Progreso anclado directo** | ✅ Insignia en barra | ❌ | ❌ | ❌ |
| **Onda de ancho de banda** | ✅ Gráfico fluido Swift Charts | ⚠️ Gráfico estático | ⚠️ Diagrama básico | ❌ |
| **Consumo de memoria** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **Uso de CPU en reposo** | 🟢 **< 0,1 %** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **Soporte NAS & Docker** | ✅ LAN, NAS & HTTPS | ✅ | ❌ Solo local | ⚠️ Soporte limitado |
| **Árbol de archivos desplegable** | ✅ Tarjetas interactivas | ⚠️ Tablas densas | ⚠️ Tabla compacta | ❌ |
| **Widgets de Escritorio y Centro de notificaciones (WidgetKit)** | ✅ Pequeño, Mediano y Grande | ❌ | ❌ | ❌ |
| **Notificaciones nativas macOS** | ✅ Alerta de descarga lista | ⚠️ Permiso navegador | ⚠️ Diálogo antiguo | ❌ |

---

## ✨ Características destacadas

1. **Monitor en tiempo real en la barra de menús**:
   - Velocidades de descarga y subida en vivo con flechas direccionales (`↓` / `↑`).
   - Porcentaje de progreso anclado (elegante insignia monocromática).
   - Ajuste dinámico del ancho del texto para evitar texto cortado en la barra.
2. **Panel flotante Liquid Glass**:
   - Material Liquid Glass translúcido nativo de macOS con sutiles reflejos de luz.
   - Gráfico de onda de ancho de banda fluido impulsado por Swift Charts.
   - Acciones rápidas: Pausar todo, Reanudar todo, Velocidad alternativa (🐢 modo tortuga), Abrir WebUI.
   - Pestañas de filtrado: Todos, Descargando, Sembrando, En pausa.
   - **➕ Agregar torrent local**: Previsualización de archivos antes de descargar y selección de destino.
   - **📋 Portapapeles inteligente**: Reconocimiento automático de enlaces `magnet:` y URLs copiadas.
3. **Tarjetas de torrents interactivas**:
   - Métricas completas: barras de progreso, tiempo restante (ETA), tamaños y tasas en directo.
   - Explorador de archivos: Despliega la estructura interna con iconos de formato y progreso individual.
   - Menú contextual: Mostrar en Finder, forzar recomprobación, eliminar (con o sin archivos).
4. **Preferencias estilo Ajustes de macOS**:
   - Diseño fijo de doble panel sin barra lateral plegable.
   - Soporte multilingüe completo en 9 idiomas (Español, Inglés, Chino, Japonés, Coreano, Alemán, Francés, Ruso).
   - Comprobador de conectividad integrado para verificar ping y versión del servidor qBittorrent.
5. **Widgets de Escritorio y Centro de notificaciones de macOS (WidgetKit)**:
   - **Widget pequeño (`.systemSmall`)**: Vista rápida de la descarga más activa con barra de progreso, velocidad en vivo y tiempo restante (ETA).
   - **Widget mediano (`.systemMedium`)**: Diseño de dos paneles con ancho de banda global a la izquierda y tareas activas a la derecha.
   - **Widget grande (`.systemLarge`)**: Panel de control completo con tarjetas de velocidad, listado de torrents, estados y acceso directo a QBMenubar.
   - **Almacenamiento compartido App Group sin consumo extra**: Sincronización transparente y ligera entre el daemon y los widgets de macOS.
   - Compatibilidad total con los modos Color, Oscuro y Tintado/Acentuado (`widgetAccentable`).

### 🧩 Widgets de Escritorio y Guía de permisos

QBMenubar admite widgets de Escritorio y Centro de notificaciones de macOS en tres tamaños (Pequeño, Mediano y Grande). Para sincronizar la velocidad y el progreso entre la barra de menús y los widgets:

1. **Activar en Preferencias**: Haz clic en el icono de la barra de menús -> Preferencias (**⌘,**) -> pestaña «**Widgets**» -> activa «**Activar sincronización de widgets de escritorio**».
2. **Permiso del sistema macOS «Datos de otras apps»**:
   - **Por qué macOS muestra este aviso**: En macOS 15 (Sequoia) y macOS 26 (Tahoe), la app de la barra de menús y la extensión WidgetKit se ejecutan en procesos separados y comparten datos a través de App Groups (`~/Library/Group Containers/`). Debido a que las versiones de código abierto se compilan con firma ad-hoc local (sin un perfil de desarrollador comercial de pago de Apple), macOS clasifica esta carpeta compartida como «Datos de otras apps» y muestra la alerta: *«“QBMenubar” intentó acceder a tus datos desde otras apps y fue bloqueado.»*
   - **🔒 Privacidad garantizada al 100 %**: QBMenubar escribe y lee **únicamente** su archivo `widget_snapshot.json` (que solo incluye el nombre de los torrents, velocidades y porcentaje de descarga). **Jamás** accede a archivos personales ni a datos de otras aplicaciones.
   - **Cómo otorgar o recuperar el permiso**:
     - **Opción 1 (Desde la propia app)**: En «Preferencias -> Widgets», haz clic en «**Volver a solicitar permiso del sistema**». macOS mostrará inmediatamente la notificación; haz clic en «Gestionar» y permite el acceso.
     - **Opción 2 (Ajustes del Sistema)**: Abre «**Ajustes del Sistema > Privacidad y seguridad > Archivos y carpetas**» (o «**Acceso total al disco**»), busca **QBMenubar** y activa la casilla.
     - **Opción 3 (Restablecer desde Terminal)**: Si denegaste el permiso anteriormente y la app no aparece en la lista de Ajustes, ejecuta en Terminal:
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
       Luego vuelve a abrir QBMenubar y activa el interruptor de widgets para recibir de nuevo el aviso de autorización.
   - **Nota**: Los widgets requieren este permiso para actualizarse en vivo (de lo contrario muestran «Se requiere permiso»). **Si no concedes este permiso, todas las funciones de monitoreo, control y descarga en la barra de menús siguen funcionando al 100 % con total normalidad.**

---

### 🚀 Novedades de la versión 1.3.2
- **Lente óptica Liquid Glass en la barra lateral de Ajustes**: Lente de cristal transparente estilo macOS Tahoe con sombras de refracción física meniscal, dispersión prismática de borde y animaciones de resorte fluidas (el estilo clásico de color sólido sigue disponible y configurable).
- **Anillo de progreso circular Liquid Glass para widgets**: Nuevo dial circular de progreso con flecha direccional e icono flotante de cristal (la barra clásica lineal se mantiene al 100 % y se puede alternar en Ajustes).
- **Punto de entrada nativo de WidgetKit optimizado**: Símbolo `_NSExtensionMain` enlazado correctamente para asegurar la detección por parte de `chronod` y el Centro de notificaciones.
- **Autorización simplificada de Acceso total al disco**: Corrección de desbordamientos de diseño y textos cortados en los ajustes.
- **Registro de paquete único**: Eliminación de conflictos de registro de paquetes redundantes.

---

## 📥 Descarga e Instalación

### Opción 1: Descarga directa de la aplicación (Recomendado)
Listo para usar, no requiere terminal ni Xcode:

👉 **[Descargar la última versión de QBMenubar (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Descomprime el archivo `QBMenubar-*-macOS.zip`.
2. Mueve `QBMenubar.app` a tu carpeta **«Aplicaciones (/Applications)»**.
3. **¡Haz doble clic en `QBMenubar.app` para iniciarla!** Aparecerá discretamente en tu barra de menús.

> [!TIP]
> **Aviso de Gatekeeper en el primer inicio:**  
> Si macOS muestra el aviso «no se puede verificar el desarrollador», haz **clic derecho (o Control + clic)** en `QBMenubar.app` dentro de Finder y selecciona **«Abrir»**.

---

## 🏷️ Palabras clave de búsqueda (Keywords)
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid`

---

## 📄 Licencia
Distribuido bajo la [Licencia MIT](LICENSE).
