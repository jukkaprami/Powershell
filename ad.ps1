# käyttäjän luominen skriptin avulla

# Salasanaa ei voi antaa selkokielisenä
$kryptattusalasana = ConvertTo-SecureString "Q1werty" -AsPlainText -Force

# luodaan tili
New-ADUser -GivenName "jukka" -SurName "prami.adm" -Name "jukka prami admin" -DisplayName "jukka prami (admin)" -SamAccountName "jukka.prami.adm" -UserPrincipalName "jukka.prami.adm@firma.intra" -Description "jukka pramin pääkäyttäjätunnus" -ChangePasswordAtLogon 1 -Enabled 1 -AccountPassword $salasana

# Lisätään käyttäjä Domain admins -ryhmään
Add-ADGroupMember -Identity  "Domain Admins" -Members "jukka.prami.adm"