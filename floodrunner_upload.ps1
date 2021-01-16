<###
Invoke FloodRunner's Rest API for running Puppeteer test
###>

Param
(
    [Parameter(Mandatory = $true)]
    [string] $apiAccessToken,
    [Parameter(Mandatory = $true)]
    [string] $FilePath,
    [Parameter(Mandatory = $false)]
    [string] $floodRunnerAPIUrl = "https://floodrunner-api.azurewebsites.net/floodtest/runtest"
)

## Create API request
$headers = @{
    'x-api-key' = $apiAccessToken
}

$form = @{
    name        = "Puppeteer Azure DevOps"
    interval    = 1 #ignored since this is a on-demand run
    type        = "puppeteer"
    description = "Puppeteer test run using the FloodRunner API"
    testFile    = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath $FilePath)
}

$response = Invoke-WebRequest -Headers $headers -Uri $floodRunnerAPIUrl -Method 'POST' -Form $form
$responseContent = ConvertFrom-Json $([String]::new($response.Content))

#Output response content
$responseContent

$statusCode = $response.StatusCode

# Check that the Puppeteer script was executed
if ($statusCode -ne 201) {
    Write-Error "Failed to execute Puppeteer script";
}

# Check that the Puppeteer script passed
if (!$responseContent.isSuccessful) {
    Write-Error "Puppeteer script failed";
}

