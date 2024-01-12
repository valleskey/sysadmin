# Define commands with descriptions, separated by '|'
$commandData = @"
ls -l | List directory contents
whoami | Display current user
df -h | Check disk space usage
uname -a | Display system information
"@

# Function to show command menu and get a valid selection
function Get-UserCommand {
    $cmdArray = @()

    # Split and process each line
    $commandData -split "`n" | ForEach-Object {
        # Split the command and its description
        $parts = $_.Trim() -split '\|', 2
        if ($parts.Count -eq 2) {
            $command = $parts[0].Trim()
            $description = $parts[1].Trim()

            # Add command to the array and display the menu item
            $index = $cmdArray.Count
            Write-Host "$index $description"
            $cmdArray += $command
        }
    }

    # Input loop for valid command selection
    do {
        $choice = Read-Host "Enter the command number"
        $isValid = $choice -match '^\d+$' -and $choice -ge 0 -and $choice -lt $cmdArray.Count
        if (-not $isValid) {
            Write-Host "Invalid choice, please try again."
        }
    } while (-not $isValid)
    
    return $cmdArray[$choice]
}

# Main script execution
$selectedCommand = Get-UserCommand
Write-Host "Executing: $selectedCommand"
# Add logic to execute the command
