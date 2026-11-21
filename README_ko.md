# ⚡️ QBMenubar — macOS 네이티브 qBittorrent & Transmission 메뉴 막대 및 데스크톱 위젯 클라이언트

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Liquid Glass 디자인이 적용된 macOS 네이티브 qBittorrent 메뉴 막대 컨트롤러" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="총 다운로드"></a>
  <img src="https://img.shields.io/badge/지원%20클라이언트-qBittorrent%20%2B%20Transmission-blue" alt="Supported Clients">
  <img src="https://img.shields.io/badge/위젯-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/플랫폼-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/아키텍처-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/라이선스-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <b>한국어</b> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar**는 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 로 제작된 가볍고 강력한 macOS 네이티브 상태 표시줄 컨트롤러입니다. 모던한 **Liquid Glass (액체 유리)** 반투명 머티리얼과 **Apple Motion Feel** 고유의 물리 스프링 애니메이션을 결합하여, CPU 0.1% 미만 및 RAM ~40MB의 극저전력으로 실시간 속도 모니터링, 고정 작업 진척률 표시, 원격 NAS WebUI 관리를 지원합니다.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar 메뉴 막대 속도 모니터 및 고정 진척도 배지" width="650" />
</p>

---

## 🎯 주요 사용 시나리오 (Use Cases)

- 🚀 **로컬 클라이언트 및 원격 NAS 통합 제어**: 로컬 Mac, 시놀로지(Synology DSM), QNAP, Unraid, TrueNAS, Docker 컨테이너 또는 원격 클라우드 서버에서 실행 중인 qBittorrent를 내부 IP, 도메인, HTTPS 역방향 프록시를 통해 즉시 연결.
- 📌 **메뉴 막대에 핵심 토렌트 진척률 핀 고정**: 중요한 다운로드 작업을 1클릭으로 핀 고정하여 메뉴 막대 시계 옆에 실시간 진척도(예: `↓ 12.0 MB/s 85%`) 상시 확인.
- ⚡️ **배터리 걱정 없는 백그라운드 상주**: 무거운 일렉트론(Electron)이나 브라우저 탭과 달리, Swift 6 네이티브 코드로 대기 중 CPU 0.0%, 메모리 35~45MB만을 소비.
- 🐢 **회의 및 게임 중 원클릭 제한 전환**: 클릭 한 번으로 모든 다운로드 일시 정지/재개 및 대체 속도 제한(🐢 거북이 모드) 토글.
- 📋 **클립보드 스마트 감지 & 사전 파일 검사**: 클립보드의 마그넷(`magnet:`) 링크 자동 감지 및 로컬 `.torrent` 파일 내부 구조 사전 확인 지원.

---

## 📸 스크린샷 & 미리보기

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass 팝오버 창" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS 시스템 설정 스타일 환경설정" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar 위젯 설정 및 데이터 접근 권한 안내" width="580" />
</p>

---

## 📊 기능 비교: 왜 QBMenubar인가?

| 기능 | QBMenubar (네이티브) | 브라우저 WebUI | 공식 Qt 데스크톱 클라이언트 | Python / SwiftBar 플러그인 |
|---|:---:|:---:|:---:|:---:|
| **메뉴 막대 상주 및 인터랙션** | ✅ 네이티브 Liquid Glass | ❌ 브라우저 창 전용 | ❌ Dock/단독 창 전용 | ⚠️ 텍스트 메뉴 전용 |
| **특정 작업 진척도 핀 고정** | ✅ 상태 표시줄 흑백 배지 | ❌ | ❌ | ❌ |
| **실시간 동적 대역폭 파형** | ✅ Swift Charts 물리 파형 | ⚠️ 정적 꺾은선 | ⚠️ 기본 그래프 | ❌ |
| **메모리 사용량** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **대기 중 CPU 점유율** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **원격 NAS & Docker 지원** | ✅ LAN / NAS / HTTPS 프록시 | ✅ | ❌ 로컬 인스턴스 전용 | ⚠️ 제한적 지원 |
| **확장형 파일 트리 미리보기** | ✅ 카드 내부 계층 확장 & 진척도 | ⚠️ 복잡한 표 반복 클릭 | ⚠️ 빽빽한 표 | ❌ |
| **데스크탑 및 알림 센터 위젯 (WidgetKit)** | ✅ 소/중/대 3가지 크기 지원 | ❌ | ❌ | ❌ |
| **macOS 네이티브 알림** | ✅ 다운로드 완료 시스템 푸시 | ⚠️ 브라우저 권한 필요 | ⚠️ 구형 알림창 | ❌ |

---

## ✨ 핵심 기능 한눈에 보기

1. **상태 표시줄 실시간 모니터**:
   - 실시간 업/다운로드 속도와 직관적인 방향 아이콘(`↓` / `↑`).
   - 고정된 다운로드 작업의 진행률(단색 흑백 캡슐 배지).
   - 텍스트 길이에 따른 동적 폭 계산으로 텍스트 잘림 방지.
2. **Liquid Glass 팝오버 패널**:
   - macOS 고유의 반투명 Liquid Glass 머티리얼과 정교한 하이라이트 림.
   - Swift Charts 기반의 실시간 물리 파형 대역폭 그래프.
   - 빠른 동작: 모두 일시정지, 모두 재개, 대체 속도 제한(🐢 거북이 모드), WebUI 바로 열기.
   - 필터 탭: 전체, 다운로드 중, 시드 중, 일시정지.
   - **➕ 토렌트 파일 업로드**: 다운로드 전 내부 파일 목록 확인 및 저장 폴더 지정.
   - **📋 클립보드 링크 감지**: 마그넷(`magnet:`) 또는 HTTP/HTTPS 토렌트 링크 복사 시 즉시 알림.
3. **대화형 토렌트 카드**:
   - 작업명, 상태 배지, 프로그레스 바, 용량, 남은 시간(ETA), 실시간 속도 확인.
   - 카드 클릭 시 내부 파일 트리가 매끄럽게 펼쳐지며 파일 유형별 아이콘 및 개별 진행률 표시.
   - 컨텍스트 메뉴: Finder에서 열기, 무결성 재검사, 삭제(데이터 파일 유지 선택 가능).
4. **macOS 시스템 설정 스타일 환경설정**:
   - 사이드바 접힘 없는 고정 2분할 레이아웃.
   - 9개 언어 완전 지원(한국어, 영어, 일본어, 중국어 간체/번체, 독일어, 프랑스어, 스페인어, 러시아어).
   - 실시간 Ping 지연 시간 및 qBittorrent 서버 버전 감지 도구 내장.
5. **macOS 데스크탑 및 알림 센터 위젯 (WidgetKit)**:
   - **소형 위젯 (`.systemSmall`)**: 가장 활발한 다운로드 작업의 진행 바, 실시간 속도, 남은 시간(ETA)을 직관적으로 확인.
   - **중형 위젯 (`.systemMedium`)**: 2단 분할 레이아웃으로 좌측엔 전체 업/다운로드 대역폭 및 작업 수, 우측엔 상위 다운로드 작업들의 프로그레스 바 표시.
   - **대형 위젯 (`.systemLarge`)**: 종합 다운로드 대시보드로 작업 목록, 상태 배지, 전송 통계 및 QBMenubar 원클릭 이동 지원.
   - **제로 오버헤드 App Group 공유 스토리지**: 백그라운드 프로세스와 macOS 알림 센터/데스크탑 간의 초고속 저전력 동기화.
   - macOS 풀컬러, 다크 모드, 틴트/액센트(`widgetAccentable`) 렌더링 완벽 지원.

### 🧩 데스크탑 위젯 및 시스템 권한 가이드

QBMenubar는 macOS 데스크탑 및 알림 센터 위젯(Small, Medium, Large 3가지 크기)을 지원합니다. 메뉴 막대 메인 앱과 위젯 간의 실시간 작업 상태 동기화:

1. **설정에서 활성화**: 메뉴 막대 아이콘 클릭 후 환경설정(**⌘,**) 열기 -> 「**위젯**」 탭 -> 「**데스크탑 위젯 동기화 활성화**」 켜기.
2. **macOS "다른 앱의 데이터" 권한 안내**:
   - **시스템 알림이 뜨는 이유**: macOS 15(Sequoia) 및 macOS 26(Tahoe)에서는 샌드박스화된 WidgetKit 확장 프로그램과 메뉴 막대 본체가 별개의 프로세스로 작동하며, App Group(`~/Library/Group Containers/`)을 통해 데이터를 교환합니다. 오픈소스 버전은 로컬 자체 서명(유료 Apple 개발자 계정 프로파일 없음)으로 배포되므로, macOS가 이 공유 폴더 접근을 "다른 앱의 데이터 접근"으로 분류하여 *“QBMenubar가 다른 앱의 데이터에 접근을 시도하여 차단되었습니다”* 알림을 표시합니다.
   - **🔒 완벽한 개인정보 보호**: QBMenubar는 공유 폴더에 자체 생성한 `widget_snapshot.json`(작업 이름, 속도, 진행률만 포함)만 읽고 쓰며, **사용자의 개인 파일이나 다른 앱의 데이터는 일절 스캔하거나 접근하지 않습니다**.
   - **권한 허용 및 재요청 방법**:
     - **방법 1 (앱 내 원클릭 재요청)**: 환경설정 -> 위젯 탭에서 「**시스템 권한 창 다시 띄우기**」를 클릭하면 시스템 알림이 즉시 다시 표시됩니다. 「관리」를 클릭하여 허용해 주세요.
     - **방법 2 (시스템 설정)**: 「**시스템 설정 > 개인정보 보호 및 보안 > 파일 및 폴더**」(또는 「**전체 디스크 접근 권한**」)에서 **QBMenubar** 항목을 허용으로 전환합니다.
     - **방법 3 (터미널 리셋)**: 이전에 거부하여 시스템 설정 목록에 나타나지 않는 경우 터미널에서 다음 명령을 실행합니다:
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
       이후 QBMenubar를 다시 열고 위젯 스위치를 켜면 시스템 승인 알림이 다시 나타납니다.
   - **참고**: 위젯이 실시간 상태를 표시하려면 이 권한이 필요합니다(미허용 시 "권한 필요" 상태 표시). **이 권한을 허용하지 않더라도 메뉴 막대 본체의 모든 모니터링, 제어, 마그넷 다운로드 기능은 100% 정상 작동합니다.**

---

### 🚀 v1.3.2 주요 업데이트 사항
- **Transmission 클라이언트 네이티브 지원**: 서비스 아키텍처 추상화를 통해 Transmission JSON-RPC 프로토콜 네이티브 지원(409 CSRF Session-Id 핸드셰이크 및 Basic 인증 자동 처리). qBittorrent와 Transmission 간 원활한 전환을 완벽 지원하며 데스크톱 위젯, 속도 그래프 및 작업 관리 기능과 100% 호환됩니다.
- **설정 사이드바 투명 리퀴드 글래스 광학 렌즈**: macOS Tahoe 크리스털 글래스 렌즈 질감 완벽 재현. 상하부 물리적 굴절 섀도우, 가장자리 프리즘 무지개 분산 효과, 스프링 모션 적용(클래식 단색 하이라이트 스타일도 설정에서 선택 가능).
- **위젯용 리퀴드 글래스 원형 프로그레스 링**: 방향성 화살표가 포함된 링 형태의 다이얼과 중앙 플로팅 글래스 인디케이터 추가(기존 클래식 선형 캡슐 바 스타일 100% 유지 및 전환 가능).
- **네이티브 WidgetKit 진입점 최적화**: `_NSExtensionMain` 링커 진입점을 보완하여 macOS `chronod` 및 알림 센터의 안정적인 위젯 감지 및 플레이스홀더 로딩 보장.
- **전체 디스크 접근 권한 안내 개선**: 위젯 권한 안내 레이아웃 오버플로우 및 텍스트 잘림 현상 해결.
- **단일 번들 등록 최적화**: 중복 바이너리 등록 충돌 방지 및 위젯 갤러리 탐색 최적화.

---

## 📥 다운로드 및 설치

### 방법 1: 사전 컴파일된 앱 다운로드 (권장)
개발 환경 설치 없이 바로 실행 가능합니다:

👉 **[최신 버전 QBMenubar 다운로드 (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. 다운로드한 `QBMenubar-*-macOS.zip`의 압축을 풉니다.
2. `QBMenubar.app`을 **「응용 프로그램 (/Applications)」** 폴더로 이동합니다.
3. **`QBMenubar.app`을 더블 클릭하여 실행**합니다! 메뉴 막대에 바로 상주합니다.

> [!TIP]
> **첫 실행 시 Gatekeeper 보안 경고 해결:**  
> 오픈소스 앱 첫 실행 시 "확인되지 않은 개발자" 알림이 나타나면, Finder에서 **`QBMenubar.app` 우클릭(또는 Control 누르고 클릭)** -> **「열기」** 를 선택해 주세요.

---


---

## ⚙️ 클라이언트 연결 가이드 (qBittorrent & Transmission)

| 클라이언트 | 권장 설정 | 포트 / 경로 | 인증 방식 |
|---|---|---|---|
| **qBittorrent** | WebUI 활성화 (API v2) | 기본 `8080` (예: `http://192.168.1.100:8080`) | 사용자 이름 & 비밀번호 |
| **Transmission** | RPC 원격 액세스 허용 | 기본 `9091` (RPC 경로: `/transmission/rpc`) | RPC 인증 & 409 CSRF 자동 처리 |

> [!TIP]
> **원클릭 클라이언트 전환:**  
> 환경설정(**⌘,**)의 「**WebUI 연결**」에서 qBittorrent 또는 Transmission을 선택하기만 하면 모든 메뉴 막대 속도 표시, 데스크톱 위젯, 토렌트 관리가 즉시 자동 전환됩니다.

---

## ❓ 자주 묻는 질문 (FAQ)

<details>
<summary><b>1. 원격 NAS, Unraid, Docker 상의 클라이언트에 연결할 수 있나요?</b></summary>
네, 로컬 Mac뿐만 아니라 Synology DSM, QNAP, Unraid, TrueNAS, Docker 컨테이너, 원격 VPS에서 실행 중인 qBittorrent 및 Transmission에 내부 IP, DDNS 도메인, HTTPS 역방향 프록시를 통해 완벽하게 연결할 수 있습니다.
</details>

<details>
<summary><b>2. 위젯 시스템 권한을 승인하지 않아도 앱을 사용할 수 있나요?</b></summary>
네, 데스크톱 위젯 동기화 권한(「다른 앱의 데이터」)을 승인하지 않더라도 메뉴 막대 본체의 실시간 속도 모니터링, 작업 핀 고정, 일시정지/재개, 마그넷 다운로드 등 모든 핵심 기능은 100% 정상 작동합니다.
</details>

<details>
<summary><b>3. 메뉴 막대 팝오버 창의 높이를 조절할 수 있나요?</b></summary>
네! v1.3.2부터 팝오버 하단의 인터랙티브 핸들 바를 위아래로 드래그하여 380pt에서 920pt까지 자유롭게 높이를 조절할 수 있습니다. 더블 클릭하면 기본값 550pt로 즉시 복귀하며 상단은 항상 메뉴 막대 바로 아래에 완벽히 고정됩니다.
</details>

<details>
<summary><b>4. 브라우저 WebUI나 일렉트론 앱보다 얼마나 가볍나요?</b></summary>
브라우저 탭(300MB~1GB RAM, CPU 1~5%)이나 일렉트론 래퍼와 달리, QBMenubar는 순수 Swift 6 네이티브 바이너리입니다. 대기 중 RAM 소비는 약 35~45MB, CPU 사용률은 0.1% 미만으로 배터리를 거의 소모하지 않습니다.
</details>

<details>
<summary><b>5. 메뉴 막대에 특정 다운로드 작업을 핀 고정하려면 어떻게 하나요?</b></summary>
팝오버 창 내의 토렌트 카드에서 핀 아이콘(📌)을 클릭하기만 하면 메뉴 막대 시계 옆에 실시간 다운로드 속도와 진척률(예: `↓ 12.0 MB/s 85%`)이 상시 표시됩니다.
</details>

## 🏷️ 검색 키워드 (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-controller` • `transmission-remote` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `menubar-extra` • `widgetkit` • `macos-widgets` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid`

---

## 📄 라이선스
이 프로젝트는 [MIT License](LICENSE)에 따라 오픈 소스로 배포됩니다.
