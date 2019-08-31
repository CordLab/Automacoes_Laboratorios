## Adiciona o usuário alunoifro do domínio ao grupo administradores.

$credencial = Get-Credential Administrador
$computers = Get-Content C:\Users\Lenovo\Desktop\labin_a_pcs.txt
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

Invoke-Command -ComputerName $online { net localgroup Administradores alunoifro /add } -Credential $credencial

#para remover o usuario do grupo use /delete
