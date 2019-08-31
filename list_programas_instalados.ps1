##Listar programas instalados e diretórios de instalação

$credencial = Get-Credential Administrador
$computers  = @("aqs-la01","aqs-lc01")
$online = @()
$offline = @()


Foreach($pc in $computers) {
    if (Test-Connection -BufferSize 32 -Count 1 -ComputerName $pc -Quiet) {

         if (Test-WSMan -ComputerName $pc ) {  $online += $pc }
         
         else  { $offline += $pc }

}

else { $offline += $pc }

}

Write-Output "O comando sera executado nos seguintes computadores: " $online 
Write-Output "Total de computadores ligados: " $online.Count 


##metodo 1 
Invoke-Command -ComputerName $online { Get-WmiObject -Class win32_product | Select-Object name, caption ; Write-Output "" } -Credential $credencial

##metodo 2 - listando pastas do sistema
Invoke-Command -ComputerName $online { Get-ChildItem -Path C:\ -Directory ; Get-ChildItem -Path C:\"Program Files" -Directory ; Get-ChildItem C:\"Program Files (x86)"\ -Directory ; Get-ChildItem -Path C:\ProgramData -Directory } -Credential $credencial

##metodo 3 ir na maquina e olhar :)