# French verison

function Remove-StringLatinCharacters
{
    PARAM ([string]$String)
    [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String))
}

$profiles =netsh wlan show profile | Select-String "Profil Tous les utilisateurs" | %{
    [String]$SSID=$_
    $SSID = $SSID.replace("Profil Tous les utilisateurs","").replace(":","").trim()
    [String]$result =netsh wlan show profile name=$SSID key=clear | Select-String 'Contenu de la cl'
    $result = Remove-StringLatinCharacters $result
    $result = $result.replace("Contenu de la cle","").replace(":","").trim()
    write-host "$SSID : $result"

}
Read-Host -Prompt "Press any key to continue or CTRL+C to quit" 
