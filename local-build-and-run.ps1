Write-Host "1. Running GitHub Actions workflow..." -ForegroundColor Yellow
act push -v

Write-Host "2. Building Docker image..." -ForegroundColor Yellow
docker build --no-cache -t my-java-app .

if ($LASTEXITCODE -eq 0) {
    Write-Host "3. Docker image build successful! Preparing to run container..." -ForegroundColor Green
    
    Write-Host "4. Checking and removing containers using port 8080..." -ForegroundColor Yellow
    $containersUsingPort = docker ps -aq --filter "publish=8080"
    if ($containersUsingPort) {
        docker stop $containersUsingPort
        docker rm $containersUsingPort
    }

    Write-Host "5. Stopping and removing existing my-java-app-container..." -ForegroundColor Yellow
    docker stop my-java-app-container 2>$null
    docker rm my-java-app-container 2>$null

    Write-Host "6. Running new Docker container..." -ForegroundColor Yellow
    docker run -d -p 8080:8080 --name my-java-app-container my-java-app

    Start-Sleep -Seconds 10  # Wait 10 seconds for the container to fully start

    Write-Host "7. Application is running at http://localhost:8080." -ForegroundColor Green
    
    # Check container status
    $containerStatus = docker inspect -f '{{.State.Status}}' my-java-app-container
    if ($containerStatus -eq "running") {
        Write-Host "8. Container is running successfully." -ForegroundColor Green
    } else {
        Write-Host "9. There is an issue with the container. Status: $containerStatus" -ForegroundColor Red
    }
} else {
    Write-Host "10. Docker image build failed. Check the logs." -ForegroundColor Red
}