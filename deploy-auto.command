#!/bin/bash
# Déploiement NON-INTERACTIF (double-clic) — resync + zip + commit + push.
cd "$(dirname "$0")"
REPO="$(pwd)"
MASTER="/Users/philippe/Documents/Claude/Projects/EDD HSNE/04_Fiche_anamnese/Dashboard_EDD_consultation.html"
echo "================ DEPLOY AUTO ================"
if [ -f "$MASTER" ]; then cp "$MASTER" "$REPO/index.html"; echo "✓ index.html resync (master)"; fi

# Régénère le ZIP hôpital téléchargeable
if [ -f outils/modele/Lancer-Ecole-du-Dos.cmd ]; then
  ZTMP="$(mktemp -d)"; ZS="$ZTMP/Ecole-du-Dos-EDD"; mkdir -p "$ZS"
  cp index.html "$ZS/Ecole-du-Dos.html"
  cp outils/modele/Lancer-Ecole-du-Dos.cmd "$ZS/"
  cp outils/modele/LISEZ-MOI.txt "$ZS/"
  rm -f "$REPO/Ecole-du-Dos-EDD.zip"
  ( cd "$ZTMP" && zip -rqX "$REPO/Ecole-du-Dos-EDD.zip" "Ecole-du-Dos-EDD" )
  rm -rf "$ZTMP"; echo "✓ ZIP régénéré"
fi

find .git -name '*.lock' -delete 2>/dev/null
if [ ! -d .git ]; then git init -b main >/dev/null; fi
git add -A
git commit -m "deploy $(date '+%Y-%m-%d %H:%M') — build 26e + bouton téléchargement ZIP hôpital" || echo "ℹ rien de nouveau à committer"
BR="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)"
echo "→ push origin $BR …"
git push origin "$BR"
echo "================ FIN (code $?) — Vercel redéploie ~1 min ================"
sleep 3
