# Construcción del HEADER
$jwt_header = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('{"alg":"HS256","typ":"JWT"}')) -replace '\+', '-' -replace '/', '_' -replace '=+$', ''
Write-Host "HEADER: $jwt_header"
 
# Construcción del PAYLOAD
$payload = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('{"email":"jordan@example.com"}')) -replace '\+', '-' -replace '/', '_' -replace '=+$', ''
Write-Host "`nPAYLOAD: $payload"
 
# Clave Secreta
$clave_secreta = 'kjndfoiafjm5f156faf'
Write-Host "`nClave Secreta: $clave_secreta"
 
# Convertir la clave secreta a hexadecimal
$hexsecreta = -join ($clave_secreta.ToCharArray() | ForEach-Object { "{0:X2}" -f [int][char]$_ })
Write-Host "`nClave en Hexadecimal: $hexsecreta"
 
# Función para convertir hexadecimal a bytes
function ConvertFrom-HexString($hex) {
    $bytes = @()
    for ($i = 0; $i -lt $hex.Length; $i += 2) {
        $bytes += [Convert]::ToByte($hex.Substring($i, 2), 16)
    }
    return $bytes
}
 
# Generar la firma HMAC
$hmac = New-Object System.Security.Cryptography.HMACSHA256
$hmac.Key = ConvertFrom-HexString $hexsecreta
$signature = $hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes("$jwt_header.$payload"))
$hmac_signatureHex = [Convert]::ToBase64String($signature) -replace '\+', '-' -replace '/', '_' -replace '=+$', ''
Write-Host "`nFirma o SIGNATURE: $hmac_signatureHex"
 
# Creando el token completo
$jwt = "$jwt_header.$payload.$hmac_signatureHex"
Write-Host "`nJSON Web TOKEN (JWT): $jwt"