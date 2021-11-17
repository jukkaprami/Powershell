# Haetaan käyttäjän tiedot
Get-ADUser -Identity "jukka.prami.adm" -Properties "displayname"`
 | Export-Csv -Path "C:\Users\administrator\My Documents\otsikot.csv"`
  -Encoding Unicode -Delimiter ";"