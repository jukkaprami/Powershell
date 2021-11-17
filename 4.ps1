# Kerätään kaikki AD:n ryhmät ja niidet jäsenet olioina vektoriin

# Määritellään uusi luokka, johon tallennetaan ryhmän ja jäsenen tiedot

class GroupAndMember
{
    [String]$GroupName
    [String]$GroupSamAccountName
    [String]$GroupCategory
    [String]$GroupScope
    [String]$MemberName
    [String]$MemberSamAccountName
    [String]$MemberPrincipalName
    [String]$MemberObjectClass
}


$Tiedosto = Read-Host -Prompt "Anna tiedostopolku ja nimi"

#Tarkistetaan, onko tiedosto tyhjä, jos on on, tallennetaan documents-kansioon nimellä GroupsAndUsers.csv
if($Tiedosto -eq "")
{
    $Tiedosto = $env:USERPROFILE + "\Documents\GroupsAndUsers.csv"
}

# Luodaan tyhjä vektori oilioiden säilytyttämistä varten
$DokumentoidutJäsenet = @()

# Luetaan ryhmät muuttujaan
$Ryhmät = Get-ADGroup -Filter *

# Käydään ryhmät yksitellen läpi For Each -silmukassa
foreach($Ryhmä in $Ryhmät)
{
    

    $Jäsenet = Get-ADGroupMember -Identity $Ryhmä.SamAccountName

    #Käydään jäsenet yksitellen läpi ja asetetaan ominaisuuksien arvot

    foreach($Jäsen in $Jäsenet)
    {

       # Luodaan objekti
       $groupAndMember = [GroupAndMember]::new()

       # Määritellään objektin ominaisuuksien arvot
       $groupAndMember.GroupName = $Ryhmä.Name
       $groupAndMember.GroupSamAccountName = $Ryhmä.SamAccountName
       $groupAndMember.GroupCategory = $Ryhmä.GroupCategory
       $groupAndMember.GroupScope = $Ryhmä.GroupScope
       $groupAndMember.MemberName = $Jäsen.name
       $groupAndMember.MemberSamAccountName = $Jäsen.SamAccountName
       $groupAndMember.MemberObjectClass = $Jäsen.ObjectClass

       # Jos objektiluokka on user, haetaan UserPrincipalName
       if($Jäsen.objectClass -eq "user")
       {

           $Käyttäjä = Get-ADUser -Identity $Jäsen.SamAccountName
           $groupAndMember.MemberPrincipalName = $Käyttäjä.UserPrincipalName

       }

        # Lisätään ryhmä vektoriin
        $DokumentoidutJäsenet = $Dokumentoidutjäsenet + $groupAndMember
    }


}

$DokumentoidutJäsenet | export-csv -Path $Tiedosto -Delimiter ";" -Encoding Unicode