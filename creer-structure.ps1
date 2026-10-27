# Cree la structure du bootcamp BI (30 jours)
# A lancer depuis la racine du repo : bootcamp-bi-30jours

$sprints = [ordered]@{
    "01 - SPRINT 1 - FONDATIONS (J1-10)" = @(
        "Jour 01 - Introduction DataViz",
        "Jour 02 - Prise en main Power BI",
        "Jour 03 - Prise en main Tableau",
        "Jour 04 - Types de donnees et nettoyage",
        "Jour 05 - Nettoyage Power Query",
        "Jour 06 - Nettoyage Tableau Prep",
        "Jour 07 - Fondamentaux de l'analyse",
        "Jour 08 - Premier Dashboard Power BI",
        "Jour 09 - Premier Dashboard Tableau",
        "Jour 10 - Bilan Sprint 1"
    )
    "02 - SPRINT 2 - ANALYSES AVANCEES (J11-20)" = @(
        "Jour 11 - Contextes de calcul",
        "Jour 12 - DAX avance Power BI",
        "Jour 13 - Table Calculations Tableau",
        "Jour 14 - Time Intelligence",
        "Jour 15 - Time Intelligence Power BI",
        "Jour 16 - Time Intelligence Tableau",
        "Jour 17 - Parametres et What-If",
        "Jour 18 - Parametres PBI et Tableau",
        "Jour 19 - Analyse geospatiale",
        "Jour 20 - Bilan Sprint 2"
    )
    "03 - SPRINT 3 - PROJET FINAL (J21-30)" = @(
        "Jour 21 - Choix dataset et problematique",
        "Jour 22 - Nettoyage et modelisation",
        "Jour 23 - Structure du dashboard",
        "Jour 24 - Dashboard Power BI Partie 1",
        "Jour 25 - Dashboard Power BI Partie 2",
        "Jour 26 - Dashboard Tableau Partie 1",
        "Jour 27 - Dashboard Tableau Partie 2",
        "Jour 28 - Comparaison et optimisation",
        "Jour 29 - Publication et rapport d'analyse",
        "Jour 30 - Portfolio final et bilan"
    )
}

foreach ($sprint in $sprints.Keys) {
    foreach ($jour in $sprints[$sprint]) {
        $dossierJour = Join-Path $sprint $jour
        New-Item -ItemType Directory -Path $dossierJour -Force | Out-Null

        # Sous-dossier Data pour les jours des sprints 1 et 2 (sauf les bilans)
        if (($sprint -notlike "03*") -and ($jour -notlike "*Bilan*")) {
            New-Item -ItemType Directory -Path (Join-Path $dossierJour "Data") -Force | Out-Null
        }
        # Sous-dossier Ressources pour le Jour 01
        if ($jour -like "Jour 01*") {
            New-Item -ItemType Directory -Path (Join-Path $dossierJour "Ressources") -Force | Out-Null
        }

        # Document de travail du jour (cree seulement s'il n'existe pas)
        $numero = $jour.Substring(5, 2)
        $doc = Join-Path $dossierJour "Document de travail - Jour $numero.md"
        if (-not (Test-Path -LiteralPath $doc)) {
            Set-Content -LiteralPath $doc -Value "# Document de travail - Jour $numero`n`n$jour`n" -Encoding UTF8
        }
    }
}

New-Item -ItemType Directory -Path "05 - RENDUS APPRENANTS" -Force | Out-Null

# .gitkeep dans les dossiers vides (Git ignore les dossiers vides)
Get-ChildItem -Directory -Recurse | Where-Object {
    $_.FullName -notmatch '\\\.git(\\|$)' -and
    -not (Get-ChildItem -LiteralPath $_.FullName -Force)
} | ForEach-Object {
    New-Item -ItemType File -Path (Join-Path $_.FullName ".gitkeep") -Force | Out-Null
}

Write-Host "Structure creee." -ForegroundColor Green
