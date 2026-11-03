param(
    [int]$Port = 8088,
    [string]$OraclePassword = ""
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
if ([string]::IsNullOrWhiteSpace($OraclePassword)) { $OraclePassword = Read-Host 'Oracle application password' }
$env:DB_PASSWORD = $OraclePassword
# User 환경변수가 설정돼 있으면 우선 사용하고, 없으면 현재 PowerShell의 값을 유지한다.
$userOpenAiKey = [Environment]::GetEnvironmentVariable('OPENAI_API_KEY', 'User')
if (-not [string]::IsNullOrWhiteSpace($userOpenAiKey)) {
    $env:OPENAI_API_KEY = $userOpenAiKey
}
$userTmdbToken = [Environment]::GetEnvironmentVariable('TMDB_READ_TOKEN', 'User')
if (-not [string]::IsNullOrWhiteSpace($userTmdbToken)) {
    $env:TMDB_READ_TOKEN = $userTmdbToken
}
$userTmdbKey = [Environment]::GetEnvironmentVariable('TMDB_API_KEY', 'User')
if (-not [string]::IsNullOrWhiteSpace($userTmdbKey)) {
    $env:TMDB_API_KEY = $userTmdbKey
}
$classpath = 'out;lib\ojdbc11-23.5.0.24.07.jar;lib\slf4j-api-2.0.13.jar;lib\slf4j-simple-2.0.13.jar'
$javaExe = 'java'

# Start Qdrant separately and keep it bound to localhost:6333.
javac -encoding UTF-8 -cp 'lib\ojdbc11-23.5.0.24.07.jar' -d out (Get-ChildItem -Recurse -Filter *.java src | ForEach-Object FullName)
if ($LASTEXITCODE -ne 0) { throw 'Java compilation failed.' }

$listener = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
if ($listener) { Stop-Process -Id $listener.OwningProcess -Force }
Start-Process -FilePath $javaExe -ArgumentList '-cp',$classpath,'project.CinehubServer',$Port -WorkingDirectory $root -WindowStyle Hidden
Start-Sleep -Seconds 2
Invoke-WebRequest -UseBasicParsing "http://127.0.0.1:$Port/api/health" | Select-Object -ExpandProperty Content
