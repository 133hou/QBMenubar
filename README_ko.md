# ⚡️ QBMenubar — macOS 네이티브 qBittorrent & Transmission 메뉴 막대 및 데스크톱 위젯 클라이언트

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Liquid Glass 디자인이 적용된 macOS 네이티브 qBittorrent & Transmission 메뉴 막대 컨트롤러" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="총 다운로드"></a>
  <img src="https://img.shields.io/badge/지원%20클라이언트-qBittorrent%20%2B%20Transmission-blue" alt="Supported Clients">
  <img src="https://img.shields.io/badge/위젯-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/플랫폼-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
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

**QBMenubar**는 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 로 제작된 가볍고 강력한 **macOS qBittorrent 메뉴 막대 앱**이자 **Transmission 원격 GUI 클라이언트 (Transgui / Transmission Remote GUI의 현대적 대체재)** 입니다. Apple Silicon (M1/M2/M3/M4) 및 Intel Mac을 완벽히 지원하며, 모던한 **Liquid Glass (액체 유리)** 반투명 머티리얼과 **Apple Motion Feel** 고유의 물리 스프링 애니메이션, macOS **데스크톱 위젯**을 결합했습니다. 로컬 Mac 다운로드 관리는 물론 **시놀로지(Synology DSM), QNAP, Unraid, TrueNAS, Docker** 홈 NAS 및 **PT / 프라이빗 트래커 시드박스(Seedbox)** 모니터링까지, 대기 중 CPU 0.1% 미만 및 RAM ~40MB의 초저전력으로 상태 표시줄에서 실시간 제어할 수 있습니다.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar 메뉴 막대 속도 모니터 및 고정 진척도 배지" width="650" />
</p>

## 🧭 빠른 이동 (Table of Contents)
- [🎯 주요 사용 시나리오 (Use Cases)](#use-cases)
- [📸 스크린샷 & 미리보기](#screenshots)
- [📊 기능 비교: 왜 QBMenubar인가?](#comparison)
- [✨ 핵심 기능 한눈에 보기](#features)
  - [🧩 데스크톱 위젯 (추가 권한 불필요)](#desktop-widgets)
- [🔒 보안, 개인정보 보호 및 안정성](#security)
- [🚀 v1.3.2 주요 업데이트 사항](#whats-new)
- [📥 다운로드 및 설치](#download)
- [⚙️ 클라이언트 연결 가이드 (qBittorrent & Transmission)](#configuration)
- [❓ 자주 묻는 질문 (FAQ)](#faq)
- [🏷️ 검색 키워드 (Keywords)](#keywords)
- [📄 라이선스](#license)

---

<a id="use-cases"></a>
## 🎯 주요 사용 시나리오 (Use Cases)

- 🚀 **로컬 클라이언트 및 원격 NAS 통합 제어**: 로컬 Mac, **시놀로지(Synology DSM), QNAP, Unraid, TrueNAS, Docker** 컨테이너 또는 원격 Linux / 클라우드 서버에서 실행 중인 qBittorrent 및 Transmission을 내부 IP, 도메인, HTTPS 역방향 프록시를 통해 즉시 원격 관리.
- 📌 **메뉴 막대에 핵심 토렌트 진척률 핀 고정**: 중요한 다운로드 작업을 1클릭으로 핀 고정하여 메뉴 막대 시계 옆에 실시간 진척도(예: `↓ 12.0 MB/s 85%`)를 상시 확인 — **PT / 프라이빗 트래커 및 시드박스 모니터링**에 최적화.
- ⚡️ **배터리 걱정 없는 백그라운드 상주**: 무거운 일렉트론(Electron)이나 브라우저 탭과 달리, Swift 6 유니버설 네이티브 코드로 대기 중 CPU 0.0%, 메모리 35~45MB만을 소비하여 배터리 수명을 완벽히 보존.
- 🐢 **회의 및 게임 중 원클릭 제한 전환**: 클릭 한 번으로 모든 다운로드 일시 정지/재개 및 대체 속도 제한(🐢 거북이 모드) 토글.
- 📋 **클립보드 스마트 감지 & 사전 파일 검사**: 클립보드의 마그넷(`magnet:?xt=`) 링크 자동 감지 및 로컬 `.torrent` 파일 내부 구조 사전 확인과 저장 경로 지정 지원.
- 🖥️ **qBittorrent macOS 데스크톱 위젯**: WidgetKit 기반의 Small, Medium, Large 크기 위젯으로 앱을 열지 않고도 바탕화면과 알림 센터에서 전송 속도와 다운로드 현황을 확인.

---

<a id="screenshots"></a>
## 📸 스크린샷 & 미리보기

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass 팝오버 창" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS 시스템 설정 스타일 환경설정" width="480" />
</p>

<p align="center">
  <em>Liquid Glass 원형 링 스타일 (신규 기능):</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>

<p align="center">
  <em>클래식 선형 캡슐 바 스타일 (완전 유지):</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>

<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar 위젯 설정 및 데스크톱 위젯 구성 안내" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 기능 비교: 왜 QBMenubar인가?

| 기능 | QBMenubar (Mac 네이티브 앱) | 브라우저 WebUI | 공식 Qt 데스크톱 클라이언트 | Transgui / 외부 스크립트 |
|---|:---:|:---:|:---:|:---:|
| **듀얼 클라이언트 엔진** | ✅ **qBittorrent & Transmission** | ❌ 단일 인스턴스 전용 | ❌ qBittorrent 전용 | ⚠️ 단일 클라이언트 / 유지보수 중단 |
| **메뉴 막대 상주 및 인터랙션** | ✅ 네이티브 Liquid Glass | ❌ 브라우저 창 전용 | ❌ Dock/단독 창 전용 | ⚠️ 텍스트 메뉴 전용 |
| **특정 작업 진척도 핀 고정** | ✅ 상태 표시줄 흑백 배지 | ❌ | ❌ | ❌ |
| **실시간 동적 대역폭 파형** | ✅ Swift Charts 물리 파형 | ⚠️ 정적 꺾은선 | ⚠️ 기본 그래프 | ❌ |
| **창 높이 자유 조절** | ✅ 하단 핸들 드래그 (380-920pt) | ⚠️ 수동 창 조절 | ⚠️ 복잡한 데스크톱 창 | ❌ 고정 |
| **메모리 사용량** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **대기 중 CPU 점유율** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **원격 NAS & Docker 지원** | ✅ LAN / NAS / HTTPS 프록시 | ✅ | ❌ 로컬 인스턴스 전용 | ⚠️ 제한적 지원 |
| **확장형 파일 트리 미리보기** | ✅ 카드 내부 계층 확장 & 진척도 | ⚠️ 복잡한 표 반복 클릭 | ⚠️ 빽빽한 표 | ❌ |
| **데스크톱 위젯 (WidgetKit)** | ✅ 소/중/대 3가지 크기 지원 | ❌ | ❌ | ❌ |
| **macOS 네이티브 알림** | ✅ 다운로드 완료 시스템 푸시 | ⚠️ 브라우저 권한 필요 | ⚠️ 구형 알림창 | ❌ |
| **Apple Silicon 네이티브 지원** | ✅ 순수 Swift 6 유니버설 | ⚠️ Web 프로세스 오버헤드 | 🟡 Rosetta / 무거운 Qt | ⚠️ Python / 외부 의존성 |

---

<a id="features"></a>
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
   - **📋 클립보드 링크 감지**: 마그넷(`magnet:?xt=`) 또는 토렌트 웹 링크 복사 시 즉시 알림.
3. **대화형 토렌트 카드**:
   - 작업명, 상태 배지, 프로그레스 바, 용량, 남은 시간(ETA), 실시간 속도 확인.
   - 카드 클릭 시 내부 파일 트리가 매끄럽게 펼쳐지며 파일 유형별 아이콘 및 개별 진행률 표시.
   - **📌 상태 표시줄 핀 고정**: 한 번의 클릭으로 작업 진행률을 메뉴 막대에 고정.
   - 컨텍스트 메뉴: Finder에서 열기, 무결성 재검사, 삭제(데이터 파일 유지 선택 가능).
4. **macOS 시스템 설정 스타일 환경설정**:
   - 사이드바 접힘 없는 고정 2분할 레이아웃.
   - 9개 언어 완전 지원(한국어, 영어, 일본어, 중국어 간체/번체, 독일어, 프랑스어, 스페인어, 러시아어).
   - 실시간 Ping 지연 시간 및 서버 버전 감지 도구 내장.
   - 역방향 프록시, API 서브패스(`/api/v2`), localhost 바이패스 지원.
5. **macOS 데스크탑 및 알림 센터 위젯 (WidgetKit)**:
   - **소형 위젯 (`.systemSmall`)**: 가장 활발한 다운로드 작업의 진행 바, 실시간 속도, 남은 시간(ETA)을 직관적으로 확인.
   - **중형 위젯 (`.systemMedium`)**: 2단 분할 레이아웃으로 좌측엔 전체 업/다운로드 대역폭 및 작업 수, 우측엔 상위 다운로드 작업들의 프로그레스 바 표시.
   - **대형 위젯 (`.systemLarge`)**: 종합 다운로드 대시보드로 작업 목록, 상태 배지, 전송 통계 및 QBMenubar 원클릭 이동 지원.
   - **제로 오버헤드 로컬 스냅샷 동기화**: 백그라운드 프로세스와 macOS 알림 센터/데스크탑 간의 초고속 저전력 동기화.
   - macOS 풀컬러, 다크 모드, 틴트/액센트(`widgetAccentable`) 렌더링 완벽 지원.

<a id="desktop-widgets"></a>
### 🧩 데스크톱 위젯 (추가 권한 불필요)

QBMenubar는 macOS 데스크톱 및 알림 센터 위젯(Small, Medium, Large 3가지 크기)을 지원합니다.

1. **설정에서 활성화**: 메뉴 막대 아이콘 클릭 후 환경설정(**⌘,**) 열기 -> 「**위젯**」 탭 -> 「**데스크톱 위젯 동기화 활성화**」 켜기.
2. **시스템 권한 불필요 (전체 디스크 접근 권한 불필요)**:
   - **🔒 로컬 샌드박스 보안 동기화**: 최신 보안 업데이트를 통해 고도로 최적화된 로컬 스냅샷 통신 방식을 적용했습니다. 기존 유틸리티와 달리 **「전체 디스크 접근 권한(Full Disk Access)」을 요구하지 않으며**, 사용자의 개인 파일이나 타 앱 데이터에 절대 접근하지 않습니다.
   - **🔋 배터리 친화적 스마트 WidgetKit 스로틀링**: macOS WidgetKit 리로드 예산(15분 단위 병합 리로드 및 상태 변경 감지)을 엄격히 준수하여 불필요한 백그라운드 폴링을 방지하고 MacBook 배터리 소모를 최소화합니다.
   - **🛡️ 깔끔한 연결 해제 및 빈 상태 대응**: 서버 미연결 상태이거나 활성 다운로드가 없을 때에도 깔끔한 상태 카드를 표출하여 화면 멈춤이나 잔여 데이터 문제를 원천 차단합니다.
3. **데스크톱에 위젯 추가 방법**:
   - macOS 바탕화면 빈 공간에서 **우클릭** -> 「**위젯 편집...**」 선택 (또는 알림 센터를 열고 하단의 「위젯 편집」 클릭).
   - 좌측 검색창에 **`QBMenubar`** 또는 **`qBittorrent`** 검색.
   - 원하는 크기(**Small**, **Medium**, **Large**)를 선택하여 데스크톱이나 알림 센터로 드래그합니다.

---

<a id="security"></a>
## 🔒 보안, 개인정보 보호 및 안정성

QBMenubar는 엔터프라이즈 수준의 데이터 무결성과 강력한 보안 설계를 바탕으로 개발되었습니다:

- 🔐 **macOS 키체인(Keychain) 암호화 보안**: WebUI 접속 비밀번호는 Apple 공식 **Keychain Services**를 통해 하드웨어 수준에서 암호화 저장되며, `UserDefaults`나 환경설정 파일에 평문으로 남지 않습니다.
- 🔋 **스마트 WidgetKit 배터리 보호 스로틀링**: 불필요한 주기적 깨움을 방지하고 적응형 리로드 스케줄링을 통해 맥북 배터리를 효율적으로 절약합니다.
- 🌐 **RFC 3986 표준 네트워킹**: 비밀번호 내 특수문자(`@`, `#`, `$`, `%`, `&`, `+`) 및 복잡한 마그넷 링크 쿼리를 표준 퍼센트 인코딩하여 전송 누락 및 인증 오류를 방지합니다.
- 🛡️ **Transmission CSRF 동시성 안전 보장**: Transmission JSON-RPC 409 Session-ID 토큰을 스레드 안전하게 관리하여 동시 다발적인 네트워크 요청 시 레이스 컨디션을 방지합니다.
- 📦 **Bencode 파서 충돌 방지**: 256단계 재귀 깊이 제한과 정수 오버플로 방지 로직이 탑재되어 비정상적으로 조작된 악성 `.torrent` 파일로부터 시스템을 안전하게 보호합니다.

---

<a id="whats-new"></a>
### 🚀 v1.3.2 주요 업데이트 사항
- **Transmission 클라이언트 네이티브 지원**: 서비스 아키텍처 추상화를 통해 Transmission JSON-RPC 프로토콜 네이티브 지원(409 CSRF Session-Id 핸드셰이크 및 Basic 인증 자동 처리). qBittorrent와 Transmission 간 원활한 전환을 완벽 지원하며 데스크톱 위젯, 속도 그래프 및 작업 관리 기능과 100% 호환됩니다.
- **macOS 키체인 암호화 및 강화된 보안**: WebUI 접속 비밀번호를 macOS 키체인에 안전하게 보관. RFC 3986 폼 인코딩, 동시성 CSRF 안전성, 악성 파일 방어 Bencode 파서 탑재.
- **스마트 WidgetKit 리로드 스로틀링 (권한 불필요)**: 전체 디스크 접근 권한 요구를 완전히 제거. 로컬 스냅샷과 지능형 리로드 제어를 통해 효율적인 위젯 동기화 실현.
- **설정 사이드바 투명 리퀴드 글래스 광학 렌즈**: macOS Tahoe 크리스털 글래스 렌즈 질감 완벽 재현. 상하부 물리적 굴절 섀도우, 가장자리 프리즘 무지개 분산 효과, 스프링 모션 적용(클래식 단색 하이라이트 스타일도 설정에서 선택 가능).
- **위젯용 리퀴드 글래스 원형 프로그레스 링**: 방향성 화살표가 포함된 링 형태의 다이얼과 중앙 플로팅 글래스 인디케이터 추가(기존 클래식 선형 캡슐 바 스타일 100% 유지 및 전환 가능).
- **네이티브 WidgetKit 진입점 최적화**: `_NSExtensionMain` 링커 진입점을 보완하여 macOS `chronod` 및 알림 센터의 안정적인 위젯 감지 및 플레이스홀더 로딩 보장.
- **단일 번들 등록 최적화**: 중복 바이너리 등록 충돌 방지 및 위젯 갤러리 탐색 최적화.

---

<a id="download"></a>
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
> 또는 터미널에서 실행: `xattr -cr /Applications/QBMenubar.app`

### 방법 2: 소스 코드에서 빌드
요구 사항: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ 클라이언트 연결 가이드 (qBittorrent & Transmission)

### qBittorrent 사용자:
1. **WebUI 활성화**: qBittorrent 실행 -> **환경설정 (Preferences) -> Web UI** -> **웹 사용자 인터페이스 (원격 제어)** 체크 (기본 포트 `8080`).
2. **QBMenubar에서 연결**: QBMenubar 설정 -> **WebUI 연결** -> 클라이언트를 **qBittorrent**로 선택. 주소(`http://127.0.0.1:8080`, API 서브패스 `/api/v2`)와 계정 정보를 입력 후 **연결 테스트** 클릭.

### Transmission 사용자:
1. **RPC 원격 접근 허용**: Transmission 실행 -> **환경설정 -> 원격 (Remote)** -> **원격 접근 허용** 체크 (기본 포트 `9091`).
2. **QBMenubar에서 연결**: QBMenubar 설정 -> **WebUI 연결** -> 클라이언트를 **Transmission**으로 변경 (기본 주소 `http://127.0.0.1:9091`, `/transmission/rpc` 자동 설정). 계정 정보 입력 후 **연결 테스트** 클릭!

---

<a id="faq"></a>
## ❓ 자주 묻는 질문 (FAQ)

<details>
<summary><b>1. QBMenubar는 macOS에서 Transmission Remote GUI (Transgui)의 훌륭한 대안인가요?</b></summary>
네, 완벽하고 현대적인 대체 프로그램입니다. 과거에 많이 쓰이던 <i>Transmission Remote GUI (Transgui)</i>는 오래된 Pascal/Lazarus 기반으로 개발되어 장기간 업데이트가 정체되었으며, Apple Silicon 네이티브 지원 및 최신 macOS UI와의 호환성이 부족합니다. QBMenubar는 최신 Swift 6 + SwiftUI로 백지상태에서 설계되어 <b>Transmission과 qBittorrent</b>를 모두 지원합니다. 세련된 Liquid Glass 반투명 디자인, 상태 표시줄 상주, 데스크톱 위젯, 실시간 대역폭 파형을 지원하며 메모리 약 40MB, CPU 0.1% 미만의 극저사양으로 매우 부드럽게 동작합니다.
</details>

<details>
<summary><b>2. QBMenubar는 WebUI 접속 비밀번호를 어떻게 안전하게 보관하나요?</b></summary>
접속 비밀번호는 Apple의 시스템 네이티브 보안 프레임워크(<code>kSecClassGenericPassword</code>)를 통해 하드웨어 수준에서 암호화되는 **macOS 키체인(Keychain)** 에 안전하게 보관됩니다. <code>UserDefaults</code>나 일반 설정 파일에 평문으로 절대 저장되지 않으며, 서버 연결 시에만 메모리에 일시 로드되어 안심하고 사용하실 수 있습니다.
</details>

<details>
<summary><b>3. 원격 NAS, Unraid, Docker 상의 클라이언트에 연결할 수 있나요?</b></summary>
네, 로컬 Mac뿐만 아니라 Synology DSM, QNAP, Unraid, TrueNAS, Docker 컨테이너, 원격 VPS에서 실행 중인 qBittorrent 및 Transmission에 내부 IP, DDNS 도메인, HTTPS 역방향 프록시를 통해 완벽하게 연결할 수 있습니다.
</details>

<details>
<summary><b>4. 위젯을 사용하기 위해 시스템 권한을 추가로 승인해야 하나요?</b></summary>
아니요. 최신 버전의 QBMenubar는 경량 로컬 스냅샷 동기화를 채택하여 전체 디스크 접근 권한과 같은 별도의 특별 권한이 전혀 필요하지 않습니다. 설정에서 위젯 동기화 스위치를 켜기만 하면 바로 사용하실 수 있습니다.
</details>

<details>
<summary><b>5. 메뉴 막대 팝오버 창의 높이를 조절할 수 있나요?</b></summary>
네! 팝오버 하단의 인터랙티브 핸들 바를 위아래로 드래그하여 380pt에서 920pt까지 자유롭게 높이를 조절할 수 있습니다. 더블 클릭하면 기본값 550pt로 즉시 복귀하며 상단은 항상 메뉴 막대 바로 아래에 완벽히 고정됩니다.
</details>

<details>
<summary><b>6. 브라우저 WebUI나 일렉트론 앱보다 얼마나 가볍나요?</b></summary>
브라우저 탭(300MB~1GB RAM, CPU 1~5%)이나 일렉트론 래퍼와 달리, QBMenubar는 순수 Swift 6 네이티브 바이너리입니다. 대기 중 RAM 소비는 약 35~45MB, CPU 사용률은 0.1% 미만으로 배터리를 거의 소모하지 않습니다.
</details>

<details>
<summary><b>7. 메뉴 막대에 특정 다운로드 작업을 핀 고정하려면 어떻게 하나요?</b></summary>
팝오버 창 내의 토렌트 카드에서 핀 아이콘(📌)을 클릭하기만 하면 메뉴 막대 시계 옆에 실시간 다운로드 속도와 진척률(예: `↓ 12.0 MB/s 85%`)이 상시 표시됩니다.
</details>

---

<a id="keywords"></a>
## 🏷️ 검색 키워드 (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-macos` • `transmission-mac` • `qbittorrent-menu-bar` • `transmission-remote-gui` • `transgui-alternative` • `qbittorrent-remote` • `transmission-rpc` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `widgetkit` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `seedbox-monitor` • `pt-client` • `synology-nas` • `qnap` • `unraid` • `truenas` • `docker-torrent` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 라이선스
이 프로젝트는 [MIT License](LICENSE)에 따라 오픈 소스로 배포됩니다.
