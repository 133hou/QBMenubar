# QBMenubar - macOS 네이티브 qBittorrent 메뉴바 컨트롤러

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
  <b>한국어</b> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**Swift 6 + SwiftUI + MenuBarExtra (.window)** 로 제작된 가볍고 강력한 macOS 네이티브 상태 표시줄 앱입니다. **Liquid Glass** 글래스모피즘 디자인과 **Apple Motion Feel** 물리 기반 스프링 애니메이션을 적용하여 Mac 메뉴바에서 언제든지 qBittorrent 다운로드를 모니터링하고 제어할 수 있습니다.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="메뉴바 헤더 미리보기" width="650" />
</p>

---

## 스크린샷

<p align="center">
  <img src="docs/images/preview_popover.png" alt="팝오버 패널 미리보기" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="설정 창 미리보기" width="480" />
</p>

---

## 주요 기능

1. **메뉴바 상태 표시**:
   - 실시간 업로드 및 다운로드 속도 표시.
   - 고정된 다운로드 작업의 진행률을 메뉴바에 직접 표시 (예: `↓ 12.0 MB/s 85%`).
   - AppKit 폭 자동 조정으로 텍스트 잘림 현상 방지.
2. **Liquid Glass 팝오버 패널**:
   - 실시간 트래픽 파형 차트 (Swift Charts) 지원.
   - 빠른 제어 버튼: 모두 일시중지, 모두 재개, 대체 속도 제한 (🐢), WebUI 열기.
   - 탭 필터링 (전체, 다운로드 중, 배포 중, 일시중지됨).
   - **➕** 버튼을 통해 `.torrent` 파일을 선택하고 추가 전 파일 목록 및 용량을 확인 후 저장 경로 지정 가능.
   - 클립보드 내 마그넷 링크 및 토렌트 URL 빠른 감지.
3. **인터랙티브 토렌트 카드**:
   - 작업명, 상태 뱃지, 프로그레스 바, 용량, ETA 남은 시간, 속도 표시.
   - **카드 클릭 시 내부 파일 목록 부드럽게 확장**: 파일 종류별 아이콘, 파일명, 크기, 개별 진행률 확인.
   - 핀 버튼(**📌**)을 클릭하여 특정 작업 진행 상황을 메뉴바에 고정.
4. **macOS 시스템 설정 스타일 환경설정**:
   - 사이드바 접기 버튼이 없는 깔끔한 2열 레이아웃.
   - WebUI API 주소 완벽 커스터마이징 (로컬, LAN NAS, 원격 VPS, 프록시 지원).
   - 연결 테스트 도구 내장 (Ping 지연 시간 및 버전 확인).
   - 다운로드 완료 시 macOS 네이티브 시스템 알림.

---

## 설치 및 실행

### 방법 1: 사전 빌드된 앱 다운로드 (권장)
GitHub Releases에서 별도의 컴파일 없이 즉시 실행 가능한 앱을 다운로드할 수 있습니다:

👉 **[QBMenubar v1.0.0 다운로드 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. `QBMenubar-v1.0.0-macOS.zip` 파일을 다운로드하고 압축을 풉니다.
2. `QBMenubar.app`을 `/Applications` (응용 프로그램) 폴더로 이동합니다.
3. `QBMenubar.app`을 더블 클릭하여 실행합니다.

> [!TIP]
> **첫 실행 시 보안 안내 (Gatekeeper):**  
> "확인되지 않은 개발자가 배포했기 때문에 열 수 없습니다"라는 경고가 표시되는 경우:  
> Finder에서 `QBMenubar.app`을 **우클릭(또는 Control 클릭)한 후 "열기"**를 선택해주세요.  
> 또는 터미널에서 다음 명령을 실행합니다: `xattr -cr /Applications/QBMenubar.app`

### 방법 2: 소스코드 직접 빌드
요구 사항: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## 라이선스
MIT License에 따라 배포됩니다. 자세한 내용은 [LICENSE](LICENSE)를 참조하세요.
