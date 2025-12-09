# Vercel Deployment Script - Complete Guide
# Run this script to deploy your project to Vercel

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Vercel Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Vercel CLI
Write-Host "[1/5] Checking Vercel CLI..." -ForegroundColor Yellow
$vercelCheck = Get-Command vercel -ErrorAction SilentlyContinue
if (-not $vercelCheck) {
    Write-Host "Installing Vercel CLI..." -ForegroundColor Yellow
    npm install -g vercel
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install Vercel CLI!" -ForegroundColor Red
        exit 1
    }
}
Write-Host "✓ Vercel CLI is installed" -ForegroundColor Green
Write-Host ""

# Step 2: Check if logged in
Write-Host "[2/5] Checking Vercel login status..." -ForegroundColor Yellow
$vercelWhoami = vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Not logged in. Please login first:" -ForegroundColor Yellow
    Write-Host "  Run: vercel login" -ForegroundColor Cyan
    Write-Host "  Then run this script again" -ForegroundColor Cyan
    exit 1
}
Write-Host "✓ Logged in as: $vercelWhoami" -ForegroundColor Green
Write-Host ""

# Step 3: Build project
Write-Host "[3/5] Building project..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed! Please fix errors before deploying." -ForegroundColor Red
    exit 1
}
Write-Host "✓ Build successful!" -ForegroundColor Green
Write-Host ""

# Step 4: Link project (if not already linked)
Write-Host "[4/5] Linking project to Vercel..." -ForegroundColor Yellow
if (-not (Test-Path ".vercel")) {
    Write-Host "Linking project..." -ForegroundColor Cyan
    vercel link --yes
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Linking failed. You may need to login again." -ForegroundColor Yellow
        Write-Host "Run: vercel login" -ForegroundColor Cyan
        exit 1
    }
} else {
    Write-Host "✓ Project already linked" -ForegroundColor Green
}
Write-Host ""

# Step 5: Deploy to production
Write-Host "[5/5] Deploying to Vercel Production..." -ForegroundColor Yellow
Write-Host ""
vercel --prod --yes

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✓ Deployment Successful!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your project is now live on Vercel!" -ForegroundColor Cyan
    Write-Host "Check your Vercel dashboard for the deployment URL" -ForegroundColor Cyan
    Write-Host "https://vercel.com/dashboard" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  ✗ Deployment Failed" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please check the error messages above" -ForegroundColor Yellow
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "  1. Login again: vercel login" -ForegroundColor Cyan
    Write-Host "  2. Check build errors" -ForegroundColor Cyan
    Write-Host "  3. Verify vercel.json configuration" -ForegroundColor Cyan
}

