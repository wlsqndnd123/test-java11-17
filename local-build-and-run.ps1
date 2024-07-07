# GitHub Actions 워크플로우 실행
act push

# 빌드 성공 여부 확인
if ($LASTEXITCODE -eq 0) {
    Write-Host "빌드 성공! Docker 이미지 생성 및 실행 중..."
    
    # Docker 이미지 빌드
    docker build -t my-java-app .

    # 기존 컨테이너 중지 및 제거
    docker stop my-java-app-container 2>$null
    docker rm my-java-app-container 2>$null

    # 새 Docker 컨테이너 실행
    docker run -d -p 8080:8080 --name my-java-app-container my-java-app

    Write-Host "애플리케이션이 http://localhost:8080 에서 실행 중입니다."
} else {
    Write-Host "빌드 실패. 로그를 확인하세요."
}
