##Obter quais maquinas estão online na rede e com WinRM escutando.

##altere a lista conforme o laboratório
$computers = Get-Content C:\Users\eliel\Desktop\scritps_powershell\labin_c_pcs.txt
$credencial = Get-Credential Administrador
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


## use o invoke comand para executar o comando desejado nas maquinas online, ex:
## Invoke-Command -ComputerName $online { hostname; Get-Service -Name 'OCS Inventory Service', icas  | Format-Table -AutoSize } -Credential $credencial
