# Change the value $oldTime in order to set a limit for files to be deleted.
$DaysOld = 3
$now = get-date
Import-Csv "insert-your-pathname-here" | foreach {
	Get-ChildItem $_.Path -Include *.trn,*.bak -recurse -force | Where-Object {$_.LastWriteTime -le $now.AddDays(-$DaysOld)}| 
    Remove-Item -Force -whatif
}