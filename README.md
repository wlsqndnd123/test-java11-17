# GitHub Actions 및 act 테스트 프로젝트

이 프로젝트는 GitHub Actions와 act를 활용하여 CI/CD 파이프라인을 테스트하고 로컬 환경에서 실행하는 것을 목적으로 합니다.

## 프로젝트 개요

- **목적**: GitHub Actions 워크플로우 테스트 및 로컬 실행
- **사용 기술**: GitHub Actions, act
- **JDK 버전**: 11 ~ 17
- **실행 환경**: 로컬 컨테이너 기반

## 시작하기

### 필수 조건

- JDK 11 ~ 17
- Docker
- act (GitHub Actions 로컬 실행 도구)

### 설치 및 실행

1. 저장소 클론:
   ```bash
   git clone [저장소 URL]
   cd [프로젝트 디렉토리]
   ```

2. act 설치 (아직 설치하지 않은 경우):
   ```bash
   # macOS
   brew install act

   # Linux
   curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

   # Windows
   winget install -e --id Nektos.Act
   ```

3. GitHub Actions 워크플로우 로컬 실행:
   ```bash
   act
   ```
### 일반 빌드 방법

프로젝트를 빌드하려면 다음 명령어를 사용하세요:
   .\mvnw clean package
## 워크플로우 설명

(여기에 프로젝트의 주요 워크플로우 파일들과 그 역할에 대한 간단한 설명을 추가하세요)

## 기여 방법

1. 이 저장소를 포크합니다.
2. 새 브랜치를 생성합니다: `git checkout -b feature/새기능`
3. 변경사항을 커밋합니다: `git commit -am '새 기능 추가'`
4. 브랜치를 푸시합니다: `git push origin feature/새기능`
5. Pull Request를 제출합니다.

## 라이선스

이 프로젝트는 [라이선스 이름] 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.