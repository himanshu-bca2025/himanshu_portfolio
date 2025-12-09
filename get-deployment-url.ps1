# Get Vercel Deployment URL Script

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Vercel Deployment URL Generator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Please enter your Vercel deployment URL:" -ForegroundColor Cyan
Write-Host "(Example: https://your-project-name.vercel.app)" -ForegroundColor Gray
$deploymentUrl = Read-Host "Deployment URL"

if ($deploymentUrl) {
    # Remove trailing slash if present
    $deploymentUrl = $deploymentUrl.TrimEnd('/')
    
    # Extract project name
    $projectName = $deploymentUrl -replace 'https://', '' -replace '.vercel.app', ''
    $deploymentDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Create deployment info object
    $deploymentInfo = @{
        url = $deploymentUrl
        projectName = $projectName
        deploymentDate = $deploymentDate
        platform = "Vercel"
    }
    
    # Save to JSON
    $deploymentInfo | ConvertTo-Json | Out-File "deployment-url.json" -Encoding UTF8
    
    # Save to text file
    $textContent = "========================================`n"
    $textContent += "  VERCEL DEPLOYMENT INFORMATION`n"
    $textContent += "========================================`n`n"
    $textContent += "Deployment URL: $deploymentUrl`n"
    $textContent += "Project Name: $projectName`n"
    $textContent += "Deployment Date: $deploymentDate`n"
    $textContent += "Platform: Vercel`n`n"
    $textContent += "========================================`n"
    $textContent += "  QUICK LINKS`n"
    $textContent += "========================================`n`n"
    $textContent += "Live Site: $deploymentUrl`n"
    $textContent += "Dashboard: https://vercel.com/dashboard`n`n"
    $textContent += "========================================`n"
    $textContent += "  SHARE THIS LINK`n"
    $textContent += "========================================`n`n"
    $textContent += "$deploymentUrl`n`n"
    $textContent += "========================================`n"
    
    $textContent | Out-File "DEPLOYMENT-LINK.txt" -Encoding UTF8
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  URL Saved Successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Files created:" -ForegroundColor Cyan
    Write-Host "  - deployment-url.json" -ForegroundColor Yellow
    Write-Host "  - DEPLOYMENT-LINK.txt" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Your deployment URL:" -ForegroundColor Cyan
    Write-Host "  $deploymentUrl" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can share this link with others!" -ForegroundColor Cyan
    
    # Open the URL in browser
    $openBrowser = Read-Host "`nOpen URL in browser? (Y/N)"
    if ($openBrowser -eq "Y" -or $openBrowser -eq "y") {
        Start-Process $deploymentUrl
    }
} else {
    Write-Host "No URL provided. Exiting..." -ForegroundColor Red
}
