Write-Host "GitHub Actions 워크플로우 실행 중..." -ForegroundColor Yellow
act push -v

Write-Host "Docker 이미지 빌드 중..." -ForegroundColor Yellow
docker build --no-cache -t my-java-app .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker 이미지 빌드 성공! 컨테이너 실행 준비 중..." -ForegroundColor Green
    
    Write-Host "8080 포트를 사용 중인 컨테이너 확인 및 제거 중..." -ForegroundColor Yellow
    $containersUsingPort = docker ps -aq --filter "publish=8080"
    if ($containersUsingPort) {
        docker stop $containersUsingPort
        docker rm $containersUsingPort
    }

    Write-Host "기존 my-java-app-container 중지 및 제거 중..." -ForegroundColor Yellow
    docker stop my-java-app-container 2>$null
    docker rm my-java-app-container 2>$null

    Write-Host "새 Docker 컨테이너 실행 중..." -ForegroundColor Yellow
    docker run -d -p 8080:8080 --name my-java-app-container my-java-app

    Start-Sleep -Seconds 10  # 컨테이너가 완전히 시작될 때까지 10초 대기

    Write-Host "애플리케이션이 http://localhost:8080 에서 실행 중입니다." -ForegroundColor Green
    
    # 컨테이너 상태 확인
    $containerStatus = docker inspect -f '{{.State.Status}}' my-java-app-container
    if ($containerStatus -eq "running") {
        Write-Host "컨테이너가 정상적으로 실행 중입니다." -ForegroundColor Green
    } else {
        Write-Host "컨테이너 실행에 문제가 있습니다. 상태: $containerStatus" -ForegroundColor Red
    }
} else {
    Write-Host "10. Docker image build failed. Check the logs." -ForegroundColor Red
}