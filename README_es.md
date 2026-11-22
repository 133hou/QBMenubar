# ⚡️ QBMenubar — Cliente nativo de qBittorrent y Transmission para la barra de menús y widgets de escritorio de macOS

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Controlador nativo de qBittorrent y Transmission para la barra de menús de macOS con diseño Liquid Glass" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Descargas"></a>
  <img src="https://img.shields.io/badge/Clientes-qBittorrent%20%2B%20Transmission-blue" alt="Clientes compatibles">
  <img src="https://img.shields.io/badge/Widgets-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/Plataforma-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
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

**QBMenubar** es la solución nativa definitiva para la **barra de menús de macOS para qBittorrent y Transmission** y la mejor **alternativa moderna a Transmission Remote GUI (Transgui) para Mac**, desarrollada con **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Combina la estética translúcida de **Liquid Glass** y la física de muelles de **Apple Motion Feel** directamente en la barra de estado de tu Mac: monitorización de velocidad en tiempo real y gestión remota de descargas locales, NAS domésticos (**Synology DSM, QNAP, Unraid, TrueNAS, Docker**) o **seedboxes** de alta velocidad con un consumo insignificante (CPU < 0,1 %, RAM ~40 MB) en Apple Silicon e Intel.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Indicador de velocidad y porcentaje anclado en la barra de menús" width="650" />
</p>

## 🧭 Navegación rápida
- [🎯 Casos de uso clave (Use Cases)](#use-cases)
- [📸 Capturas de pantalla & Demostración](#screenshots)
- [📊 Comparativa: ¿Por qué QBMenubar?](#comparison)
- [✨ Características destacadas](#features)
  - [🧩 Widgets de Escritorio (WidgetKit) — Sin permisos especiales](#desktop-widgets)
- [🔒 Seguridad, Privacidad y Fiabilidad](#security)
- [🚀 Novedades de la versión 1.3.2](#whats-new)
- [📥 Descarga e Instalación](#installation)
- [⚙️ Guía de configuración de clientes (qBittorrent y Transmission)](#configuration)
- [❓ Preguntas frecuentes (FAQ)](#faq)
- [🏷️ Palabras clave de búsqueda (Keywords)](#keywords)
- [📄 Licencia](#license)

---

<a id="use-cases"></a>
## 🎯 Casos de uso clave (Use Cases)

- 🚀 **Control local y NAS remoto**: Monitoriza qBittorrent y Transmission ya sea en tu Mac local, NAS **Synology DSM, QNAP, Unraid, TrueNAS**, contenedores **Docker** o seedboxes remotas mediante IP de red local, dominio DDNS o proxy inverso HTTPS.
- 📌 **Fijar progreso en la barra de menús**: Ancla con un solo clic el porcentaje de descarga de un torrent prioritario directamente junto al reloj de tu Mac (ej.: `↓ 12.0 MB/s 85%`) — ideal para el seguimiento de **seedboxes y trackers privados (PT)**.
- ⚡️ **Cero impacto en batería y rendimiento**: Binario universal compilado en Swift 6 puro (Apple Silicon M1/M2/M3/M4 e Intel) que consume ~0,0 % de CPU en reposo y menos de 40 MB de RAM — invisible para el sistema frente a pestañas de navegador o apps Electron.
- 🐢 **Acciones rápidas en un clic**: Pausa y reanuda todos los torrents al instante, o activa la velocidad alternativa (🐢 modo tortuga) durante videollamadas de trabajo o sesiones de juego.
- 📋 **Detección inteligente de enlaces y archivos**: Reconocimiento automático de enlaces magnéticos (`magnet:?xt=`) y URLs de torrents en el portapapeles, con inspección completa de archivos `.torrent` y selección de carpeta de descarga antes de iniciar.
- 🖥️ **Widgets de Escritorio nativos para macOS**: Widgets intuitivos para el escritorio y el Centro de notificaciones (Pequeño, Mediano y Grande) gracias a WidgetKit, actualizados sin necesidad de abrir la aplicación ni el navegador.

---

<a id="screenshots"></a>
## 📸 Capturas de pantalla & Demostración

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Panel flotante Liquid Glass de QBMenubar" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Ventana de preferencias estilo Ajustes del Sistema de macOS" width="480" />
</p>

<p align="center">
  <em>Estilo de Anillo Circular Liquid Glass (Nuevo):</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <em>Estilo de Barra Cápsula Lineal Clásica (Conservada):</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar Ajustes de widgets y configuración de widgets de escritorio" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 Comparativa: ¿Por qué QBMenubar?

| Característica | QBMenubar (Nativo macOS) | WebUI Navegador | Cliente Qt Oficial | Transgui / Scripts Python |
|---|:---:|:---:|:---:|:---:|
| **Motor de cliente dual** | ✅ **qBittorrent y Transmission** | ❌ (Un solo cliente) | ❌ Solo qBittorrent | ⚠️ Cliente único / Antiguo |
| **Barra de menús nativa** | ✅ Nativo Liquid Glass | ❌ Solo navegador | ❌ Solo Dock / Ventana | ⚠️ Solo menú de texto |
| **Progreso anclado directo** | ✅ Insignia en barra de estado | ❌ | ❌ | ❌ |
| **Onda de ancho de banda** | ✅ Gráfico fluido Swift Charts | ⚠️ Gráfico estático | ⚠️ Diagrama básico | ❌ |
| **Altura de ventana ajustable** | ✅ Tirador interactivo (380-920pt) | ⚠️ Ventana manual | ⚠️ Ventana compleja | ❌ Texto fijo |
| **Consumo de memoria** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **Uso de CPU en reposo** | 🟢 **< 0,1 %** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **Soporte NAS & Docker remoto** | ✅ LAN, NAS y HTTPS Proxy | ✅ | ❌ Solo local | ⚠️ Soporte limitado |
| **Árbol de archivos desplegable** | ✅ Tarjetas interactivas | ⚠️ Tablas densas | ⚠️ Tabla compacta | ❌ |
| **Widgets de Escritorio (WidgetKit)** | ✅ Pequeño, Mediano y Grande | ❌ | ❌ | ❌ |
| **Notificaciones nativas macOS** | ✅ Alerta de descarga lista | ⚠️ Permiso navegador | ⚠️ Diálogo antiguo | ❌ |
| **Nativo para Apple Silicon (M1 a M4)** | ✅ Binario universal Swift 6 puro | ⚠️ Pestaña web pesada | 🟡 Rosetta / Qt pesado | ⚠️ Depende de scripts |

---

<a id="features"></a>
## ✨ Características destacadas

1. **Monitor en tiempo real en la barra de menús**:
   - Velocidades de descarga y subida en vivo con flechas direccionales (`↓` / `↑`).
   - Porcentaje de progreso anclado (elegante insignia monocromática de cápsula).
   - Ajuste dinámico del ancho del texto para evitar cortes de texto en la barra de estado.
2. **Panel flotante Liquid Glass**:
   - Material Liquid Glass translúcido nativo de macOS con sutiles reflejos de luz especular.
   - Gráfico de onda de ancho de banda fluido impulsado por Swift Charts.
   - Acciones rápidas: Pausar todo, Reanudar todo, Velocidad alternativa (🐢 modo tortuga), Abrir WebUI.
   - Pestañas de filtrado con recuento: Todos, Descargando, Sembrando, En pausa.
   - **➕ Agregar torrent local**: Previsualización de archivos antes de descargar y selección de destino.
   - **📋 Portapapeles inteligente**: Reconocimiento automático de enlaces `magnet:?xt=` y URLs copiadas.
3. **Tarjetas de torrents interactivas**:
   - Métricas completas: barras de progreso, tiempo restante (ETA), tamaños y tasas en directo.
   - Explorador de archivos: Despliega la estructura interna con iconos de formato y progreso individual.
   - **📌 Fijar en la barra de estado**: Fija tu descarga activa a la barra de menús con un solo clic.
   - Menú contextual: Mostrar en Finder, forzar recomprobación, eliminar (con o sin archivos).
4. **Preferencias estilo Ajustes del Sistema de macOS**:
   - Diseño fijo de doble panel sin barra lateral plegable.
   - Soporte multilingüe completo en 9 idiomas (Español, Inglés, Chino, Japonés, Coreano, Alemán, Francés, Ruso).
   - Comprobador de conectividad integrado para verificar ping y versión del servidor.
   - Soporte total para proxies inversos, prefijos de ruta (`/api/v2`, `/transmission/rpc`) y omisión de localhost.
5. **Widgets de Escritorio y Centro de notificaciones de macOS (WidgetKit)**:
   - **Widget pequeño (`.systemSmall`)**: Vista rápida de la descarga más activa con barra de progreso, velocidad en vivo y tiempo restante (ETA).
   - **Widget mediano (`.systemMedium`)**: Diseño de dos paneles con ancho de banda global a la izquierda y tareas activas a la derecha.
   - **Widget grande (`.systemLarge`)**: Panel de control completo con tarjetas de velocidad, listado de torrents, estados y acceso directo a QBMenubar.
   - **Sincronización por instantánea local sin impacto**: Sincronización ultraligera entre el daemon y los widgets de macOS.
   - Compatibilidad total con los modos Color, Oscuro y Tintado/Acentuado (`widgetAccentable`).

<a id="desktop-widgets"></a>
### 🧩 Widgets de Escritorio (WidgetKit) — Sin permisos especiales

QBMenubar admite widgets de Escritorio y del Centro de notificaciones de macOS en tres tamaños (`Pequeño`, `Mediano` y `Grande`), permitiéndote supervisar descargas activas y ancho de banda en todo momento.

1. **Activar en Preferencias**: Haz clic en el icono de la barra de menús -> Preferencias (**⌘,**) -> pestaña «**Widgets**» -> activa «**Activar sincronización de widgets de escritorio**».
2. **Sin permisos especiales requeridos (Cero Acceso total al disco)**:
   - **🔒 Sandbox nativo y privacidad total**: Los widgets de escritorio se sincronizan a través de un sistema de instantáneas locales optimizado. A diferencia de versiones previas, QBMenubar **no requiere Acceso total al disco (Full Disk Access)** y no accede a ningún archivo personal ni a datos de otras aplicaciones.
   - **🔋 Regulación inteligente de batería (Reload Throttling)**: Las actualizaciones se adaptan a las cuotas energéticas del sistema WidgetKit para proteger la batería de tu MacBook sin demoras perceptibles.
   - **🛡️ Estado desconectado limpio y autorreparable**: Si qBittorrent o Transmission están desconectados o fuera de línea, los widgets muestran un estado claro sin bloquearse ni mostrar datos obsoletos.
3. **Cómo añadir widgets al escritorio**:
   - Haz clic con el botón derecho en cualquier espacio vacío del escritorio de macOS -> haz clic en **«Editar widgets...»** (o abre el Centro de notificaciones y haz clic en **«Editar widgets»** al final).
   - En la barra lateral izquierda o en el cuadro de búsqueda, busca **`QBMenubar`** o **`qBittorrent`**.
   - Elige el tamaño deseado (**Pequeño**, **Mediano** o **Grande**) y arrástralo directamente a tu escritorio o al Centro de notificaciones.

---

<a id="security"></a>
## 🔒 Seguridad, Privacidad y Fiabilidad

QBMenubar implementa estándares de seguridad y estabilidad de nivel empresarial:

- 🔐 **Credenciales cifradas en el Llavero de macOS (Keychain)**: Las contraseñas de autenticación de la WebUI se guardan cifradas en el **Llavero nativo de macOS** utilizando el framework de Seguridad de Apple (`kSecClassGenericPassword`), evitando por completo el almacenamiento en texto plano en `UserDefaults` o ficheros de configuración.
- 🔋 **Regulación inteligente de WidgetKit para la batería**: El control adaptativo de frecuencia de actualización preserva la autonomía de los portátiles Mac a la vez que mantiene los widgets al día.
- 🌐 **Red reforzada (Estándar RFC 3986)**: La codificación estricta de formularios URL garantiza que las contraseñas complejas con caracteres especiales (`@`, `#`, `$`, `%`, `&`, `+`) y enlaces magnéticos complejos se transmitan sin corrupción ni truncamiento.
- 🛡️ **Seguridad de concurrencia CSRF para Transmission**: Serialización segura de tokens 409 Session-ID que previene condiciones de carrera durante peticiones simultáneas de red.
- 📦 **Analizador Bencode protegido**: Límite de recursividad a 256 niveles y protecciones contra desbordamiento de enteros frente a ficheros `.torrent` maliciosos o corruptos.

---

<a id="whats-new"></a>
### 🚀 Novedades de la versión 1.3.2
- **Compatibilidad nativa con cliente Transmission**: Arquitectura de servicios desacoplada con soporte nativo para el protocolo JSON-RPC de Transmission (gestión automática de negociación 409 CSRF Session-Id y autenticación Basic Auth). Cambio fluido entre qBittorrent y Transmission con compatibilidad total en widgets de escritorio, gráficos de velocidad y gestión de tareas.
- **Cifrado en el Llavero de macOS y seguridad reforzada**: Las contraseñas WebUI se almacenan cifradas en el Llavero de macOS. La capa de red aplica codificación RFC 3986, gestión de concurrencia para CSRF de Transmission y protección recursiva en el parseador Bencode.
- **Sincronización eficiente de WidgetKit (Sin permisos especiales)**: Se elimina el requisito de Acceso total al disco. Los widgets se actualizan mediante instantáneas locales con control de consumo de batería.
- **Lente óptica Liquid Glass en la barra lateral de Ajustes**: Lente de cristal transparente estilo macOS Tahoe con sombras de refracción física meniscal, dispersión prismática de borde y animaciones de resorte fluidas (el estilo clásico de color sólido sigue disponible y configurable).
- **Anillo de progreso circular Liquid Glass para widgets**: Nuevo dial circular de progreso con flecha direccional e icono flotante de cristal (la barra clásica lineal se mantiene al 100 % y se puede alternar en Ajustes).
- **Punto de entrada nativo de WidgetKit optimizado**: Símbolo `_NSExtensionMain` enlazado correctamente para asegurar la detección por parte de `chronod` y el Centro de notificaciones.
- **Registro de paquete único**: Eliminación de conflictos de registro de paquetes redundantes y detección limpia por parte del sistema.

---

<a id="installation"></a>
## 📥 Descarga e Instalación

### Opción 1: Descarga directa de la aplicación (Recomendado)
Listo para usar, no requiere terminal ni Xcode:

👉 **[Descargar la última versión de QBMenubar (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Descomprime el archivo `QBMenubar-*-macOS.zip`.
2. Mueve `QBMenubar.app` a tu carpeta **«Aplicaciones (/Applications)»**.
3. **¡Haz doble clic en `QBMenubar.app` para iniciarla!** Aparecerá discretamente en tu barra de menús.

> [!TIP]
> **Aviso de Gatekeeper en el primer inicio:**  
> Si macOS muestra el aviso «no se puede verificar el desarrollador» (habitual en proyectos de código abierto sin certificado comercial de pago):  
> Haz **clic derecho (o Control + clic)** en `QBMenubar.app` dentro de Finder, selecciona **«Abrir»** y confirma en el cuadro de diálogo.  
> También puedes ejecutar en la Terminal: `xattr -cr /Applications/QBMenubar.app`

### Opción 2: Compilar desde el código fuente (Build from Source)
Requisitos: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ Guía de configuración de clientes (qBittorrent y Transmission)

| Cliente | Configuración recomendada | Puerto / Ruta | Autenticación |
|---|---|---|---|
| **qBittorrent** | Habilitar WebUI (API v2) | Puerto predeterminado `8080` (ej: `http://192.168.1.100:8080`) | Usuario y Contraseña |
| **Transmission** | Habilitar acceso remoto RPC | Puerto predeterminado `9091` (Ruta RPC: `/transmission/rpc`) | Auth RPC y Gestión automática CSRF 409 |

> [!TIP]
> **Cambio de cliente en un clic:**  
> En Configuración (**⌘,**), bajo «**Conexión WebUI**», seleccione qBittorrent o Transmission para cambiar al instante todo el monitoreo y gestión de descargas.

---

<a id="faq"></a>
## ❓ Preguntas frecuentes (FAQ)

<details>
<summary><b>1. ¿Es QBMenubar una buena alternativa a Transmission Remote GUI (Transgui) en macOS?</b></summary>
Sí, por completo. Mientras que <i>Transmission Remote GUI (Transgui)</i> fue muy popular históricamente, está construido sobre librerías anticuadas en Pascal/Lazarus, carece de una interfaz moderna integrada en macOS y no funciona de forma nativa en Apple Silicon. QBMenubar ha sido desarrollado desde cero en Swift 6 tanto para Apple Silicon como para Intel. Soporta tanto <b>Transmission como qBittorrent</b>, ofrece diseño Liquid Glass, se aloja discretamente en la barra de menús, cuenta con widgets de escritorio nativos y apenas consume CPU (&lt;0,1 %) y memoria RAM (~40 MB).
</details>

<details>
<summary><b>2. ¿Cómo se guardan de forma segura las contraseñas de la WebUI?</b></summary>
Tus credenciales se cifran y guardan en el <b>Llavero nativo de macOS (Keychain)</b> mediante el framework de Seguridad de Apple (<code>kSecClassGenericPassword</code>). Las contraseñas nunca se almacenan en texto plano en <code>UserDefaults</code>, archivos plist ni exportaciones. No se requiere Acceso total al disco (Full Disk Access) ni ningún otro permiso peligroso.
</details>

<details>
<summary><b>3. ¿Puedo usar QBMenubar tanto con qBittorrent como con Transmission?</b></summary>
¡Sí! QBMenubar dispone de una arquitectura unificada de abstracción de clientes. Simplemente elige <b>qBittorrent</b> o <b>Transmission</b> en <b>Ajustes -> Conexión WebUI</b>. Las velocidades de la barra de menús, las tarjetas emergentes, los gráficos de ondas y los widgets de escritorio son totalmente compatibles con ambos servidores.
</details>

<details>
<summary><b>4. ¿Puedo conectarme a clientes remotos en NAS, Unraid o Docker?</b></summary>
Sí. Introduce la dirección IP de tu dispositivo (ej: <code>http://192.168.1.100:8080</code> o <code>http://nas.local:9091</code>), tu nombre de dominio o la URL del proxy inverso HTTPS en el campo Dirección del servidor. QBMenubar funciona a la perfección en red local (LAN), mediante VPN (Tailscale, WireGuard) o proxies inversos con subrutas en Synology DSM, QNAP, Unraid, TrueNAS o servidores remotos.
</details>

<details>
<summary><b>5. ¿Cómo añado widgets de escritorio en macOS Sonoma, Sequoia y Tahoe?</b></summary>
Haz clic con el botón derecho en cualquier espacio vacío del escritorio (o haz clic en <b>Editar widgets</b> en el Centro de notificaciones), busca <b>QBMenubar</b> y arrastra el tamaño deseado (<b>Pequeño</b>, <b>Mediano</b> o <b>Grande</b>) a tu pantalla. En las Preferencias puedes alternar entre el <b>anillo circular Liquid Glass</b> y la <b>barra cápsula clásica</b>. No se necesita ningún permiso especial.
</details>

<details>
<summary><b>6. ¿Cuánto consume en comparación con la interfaz web o Electron?</b></summary>
A diferencia de pestañas abiertas en el navegador (300 MB a 1 GB de RAM, 1-5 % de CPU) o aplicaciones Electron, QBMenubar es una app nativa en Swift 6. Se comunica mediante peticiones JSON/REST/RPC optimizadas y consume solo entre 35 y 45 MB de RAM y menos de 0,1 % de CPU en reposo.
</details>

<details>
<summary><b>7. ¿Se puede cambiar la altura de la ventana emergente?</b></summary>
¡Sí! Puedes arrastrar el tirador inferior en forma de cápsula hacia arriba o hacia abajo para ajustar la altura entre <b>380pt y 920pt</b>. La altura se recuerda automáticamente, y un doble clic en el tirador devuelve la ventana a la altura predeterminada de 550pt de forma instantánea.
</details>

---

<a id="keywords"></a>
## 🏷️ Palabras clave de búsqueda (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-macos` • `qbittorrent-menu-bar` • `transmission-remote-gui` • `transgui-alternative` • `transmission-mac` • `qbittorrent-remote` • `transmission-rpc` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `menubar-extra` • `widgetkit` • `widgets-escritorio` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `cliente-torrent` • `monitor-seedbox` • `synology-nas` • `qnap` • `unraid` • `truenas` • `docker-torrent` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 Licencia
Distribuido bajo la [Licencia MIT](LICENSE).
