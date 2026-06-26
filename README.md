# EDD HSNE — Dashboard de consultation (École du Dos)

Outil **hors-ligne, fichier unique** d'aide au contact patient pour l'École du Dos
(rééducation du rachis · HSNE Eupen · INAMI 558994).

- `index.html` — le dashboard complet (anamnèse FR/DE, body chart, effort, scores, modèle planétaire + CIF, document T0, test de sortie T1). Polices Nunito **embarquées** (aucun appel externe).
- Fonctionne en `file://` (double-clic) **ou** servi en statique (Vercel).
- **Source de vérité** = le master `04_Fiche_anamnese/Dashboard_EDD_consultation.html`. Ici, `index.html` en est une copie poussée par `deploy.command`.

## RGPD
Aucune donnée patient ne quitte le poste : tout est client-side. Les documents T0/T1 sont anonymes (n° de dossier) ; le nom n'apparaît que dans le nom de fichier généré. Le site en ligne est en `noindex` (cf. `vercel.json` + `robots.txt`).

## Mettre à jour la prod
Double-clique sur **`deploy.command`** (macOS) → resync depuis le master, commit, push → Vercel redéploie automatiquement.

## Version hôpital (hors-ligne Windows/Edge)
Double-clique sur **`outils/faire-zip-hopital.command`** → génère `Ecole-du-Dos-EDD.zip` à copier sur le poste Edge de l'hôpital.

Voir `DEPLOIEMENT.md` pour la procédure complète (première fois incluse).
