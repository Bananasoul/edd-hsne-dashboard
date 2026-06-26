#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
TOOLS="$(pwd)"
REPO="$(cd .. && pwd)"

if [ ! -f "$REPO/index.html" ]; then echo "❌ index.html introuvable dans $REPO"; read -r -p "Entrée pour fermer."; exit 1; fi

TMP="$(mktemp -d)"
STAGE="$TMP/Ecole-du-Dos-EDD"
mkdir -p "$STAGE"
cp "$REPO/index.html"               "$STAGE/Ecole-du-Dos.html"
cp "$TOOLS/modele/Lancer-Ecole-du-Dos.cmd" "$STAGE/"
cp "$TOOLS/modele/LISEZ-MOI.txt"    "$STAGE/"

OUT="$REPO/Ecole-du-Dos-EDD.zip"
rm -f "$OUT"
( cd "$TMP" && zip -r -X "$OUT" "Ecole-du-Dos-EDD" >/dev/null )
rm -rf "$TMP"

echo "✅ ZIP créé :"
echo "   $OUT"
echo "   → copie-le sur le poste Windows/Edge de l'hôpital, décompresse, double-clic sur le .cmd."
open -R "$OUT" 2>/dev/null || true
read -r -p "Entrée pour fermer."
