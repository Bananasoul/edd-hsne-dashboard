# Déploiement — EDD HSNE Dashboard

Deux canaux, une seule source de vérité (le **master**
`04_Fiche_anamnese/Dashboard_EDD_consultation.html`) :

```
                 ┌──────────────────────────────────────────────┐
   MASTER  ─────►│  deploy.command   →  GitHub  →  Vercel (online) │
 (tu édites)     └──────────────────────────────────────────────┘
        │
        └───────►  faire-zip-hopital.command  →  ZIP hors-ligne (hôpital Windows/Edge)
```

Tu n'édites JAMAIS `index.html` ici à la main : il est écrasé depuis le master à chaque déploiement.

---

## A. Mise en ligne (GitHub + Vercel) — PREMIÈRE FOIS

1. **Crée le dépôt GitHub** (vide, sans README) :
   `https://github.com/new` → nom `edd-hsne-dashboard` → **Private** → *Create*.
2. **Premier déploiement** : double-clic sur **`deploy.command`**.
   - Il resynchronise `index.html`, initialise git, te demande l'URL `.git` du dépôt
     (`https://github.com/Bananasoul/edd-hsne-dashboard.git`), commit et push.
   - Si Git demande une authentification : utilise un *Personal Access Token* GitHub
     (Settings → Developer settings → Tokens) ou GitHub Desktop déjà connecté.
3. **Connecte Vercel** : `https://vercel.com/new` → *Import Git Repository* →
   choisis `edd-hsne-dashboard` → *Deploy*.
   - Framework preset : **Other** (site statique, pas de build).
   - URL obtenue : `https://edd-hsne-dashboard.vercel.app` (≈, modifiable dans Vercel → Settings → Domains).
   - `vercel.json` applique déjà `noindex` + en-têtes de sécurité.

> Vercel est maintenant **branché sur le dépôt** : tout push ultérieur redéploie tout seul.

## B. Mise à jour de la prod — À CHAQUE FOIS

1. Tu modifies le master (via Claude).
2. Double-clic sur **`deploy.command`** → message de commit → push.
3. Vercel redéploie en ~1 min. ✅

C'est ton workflow « chaque modif → on demande → on push » : le script demande
le message, tu valides, ça part.

## C. Version hôpital (hors-ligne Windows + Edge)

> **Le plus simple** : le ZIP est **téléchargeable depuis le site lui-même**.
> Sur le poste de l'hôpital, ouvre `https://edd-hsne-dashboard.vercel.app`, écran **Accueil** →
> bouton **« ⬇ Télécharger le ZIP hôpital »** (visible uniquement en ligne) → décompresse →
> double-clic sur `Lancer-Ecole-du-Dos.cmd`. `deploy.command` régénère ce ZIP à chaque push,
> donc le téléchargement est toujours au build courant.

Variante manuelle (clé USB) :

1. Double-clic sur **`outils/faire-zip-hopital.command`** → crée `Ecole-du-Dos-EDD.zip`.
2. Copie le ZIP sur le poste de l'hôpital (clé USB / réseau).
3. Décompresse, puis double-clic sur **`Lancer-Ecole-du-Dos.cmd`** (ouvre dans Edge),
   ou directement sur `Ecole-du-Dos.html`.
4. 100 % hors-ligne, polices embarquées, aucune donnée ne sort du poste.

Mise à jour de l'hôpital : régénère le ZIP (étape 1) et remplace le fichier `.html` sur le poste.

---

## Notes
- **RGPD** : application entièrement client-side ; le online est en `noindex` et ne stocke rien.
  Si tu préfères que le online ne soit accessible qu'avec mot de passe → Vercel → Settings →
  *Deployment Protection* → *Password Protection* (plan Pro).
- **Pourquoi un dépôt dédié** (séparé du questionnaire `prototype-edd`) : URL propre,
  cycle de release indépendant, pas de risque de casser le questionnaire en déployant le dashboard.
- Le questionnaire reste embarqué **dans** le dashboard (bundle base64), donc l'outil ne dépend
  pas du site `prototype-edd-evaluation.vercel.app` pour fonctionner.
