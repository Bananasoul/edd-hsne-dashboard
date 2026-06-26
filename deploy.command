#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
REPO="$(pwd)"
MASTER="/Users/philippe/Documents/Claude/Projects/EDD HSNE/04_Fiche_anamnese/Dashboard_EDD_consultation.html"

echo "================================================"
echo "  Déploiement — EDD HSNE Dashboard"
echo "================================================"
if [ ! -f "$MASTER" ]; then echo "❌ Master introuvable :"; echo "   $MASTER"; read -r -p "Entrée pour fermer."; exit 1; fi

# 1) Resync depuis le master (source de vérité)
cp "$MASTER" "$REPO/index.html"
echo "✓ index.html resynchronisé depuis le master"

# 2) Init / réparation git
#    (nettoie d'éventuels verrous laissés par une copie/synchro, puis vérifie l'intégrité)
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true
if [ -d .git ] && ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "ℹ dépôt git incomplet → réinitialisation propre"; rm -rf .git
fi
if [ ! -d .git ]; then git init -b main >/dev/null; echo "✓ dépôt git initialisé"; fi

# 3) Remote origin
if ! git remote get-url origin >/dev/null 2>&1; then
  echo
  echo "Aucun dépôt distant 'origin' configuré."
  echo "  1) Crée un dépôt VIDE sur GitHub (ex : edd-hsne-dashboard), SANS README/licence."
  read -r -p "  2) Colle l'URL .git ici : " URL
  if [ -n "${URL:-}" ]; then git remote add origin "$URL"; echo "✓ origin = $URL"; else echo "❌ Pas d'URL, abandon."; read -r -p "Entrée pour fermer."; exit 1; fi
fi

# 4) Commit
git add -A
if git diff --cached --quiet; then
  echo "ℹ Rien de nouveau à committer."
else
  DEF="MAJ dashboard $(date +%Y-%m-%d)"
  read -r -p "Message de commit [$DEF] : " MSG
  MSG="${MSG:-$DEF}"
  git commit -m "$MSG" >/dev/null
  echo "✓ commit : $MSG"
fi

# 5) Push
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "Push vers origin/$BRANCH …"
git push -u origin "$BRANCH"

echo
echo "✅ Poussé sur GitHub. Vercel redéploie automatiquement (~1 min)."
echo "   (Si le projet Vercel n'est pas encore créé : vercel.com → Add New → Import ce dépôt.)"
read -r -p "Entrée pour fermer."
