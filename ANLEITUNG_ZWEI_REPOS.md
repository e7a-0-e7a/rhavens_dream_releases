# Zwei-Repos-Setup – Anleitung

Dieser Ordner (`release_repo/`) ist der **Inhalt für dein öffentliches Repo**.  
Quellcode bleibt im **privaten** Repo.

---

## 1. Öffentliches Repo anlegen

1. Auf GitHub ein **neues, leeres Repo** erstellen (z. B. `rhavens_dream_releases`).
2. **Public**, ohne README/Lizenz (leer).
3. In **e7a-0-e7a** und **rhavens_dream_releases** in allen Dateien hier deinen GitHub-Namen bzw. den Repo-Namen eintragen:
   - `README.md`: alle `e7a-0-e7a` ersetzen.
   - `install.sh`: Zeile mit `REPO=`: `e7a-0-e7a` ersetzen.

4. Diesen Ordner als eigenes Repo pushen:

   ```bash
   cd release_repo
   git init
   git add README.md install.sh
   git commit -m "Initial: README and install script"
   git remote add origin https://github.com/e7a-0-e7a/rhavens_dream_releases.git
   git push -u origin main
   ```

---

## 2. Binaries erstellen (privates Repo)

**Option A – Lokal bauen und per Hand hochladen**

```bash
# Im privaten Repo (oh_my_posh_clone):
./scripts/build_releases.sh
# Dann in target/release-dist/ die Dateien ins öffentliche Repo
# unter "Releases" → neues Release (z. B. v0.1.0) als Assets hochladen.
```

**Option B – GitHub Actions (empfohlen)**

1. Im **privaten** Repo unter Settings → Secrets: **PUBLIC_REPO_TOKEN** anlegen.  
   Wert: Personal Access Token (GitHub → Settings → Developer settings → PAT) mit Scope **repo** für das **öffentliche** Repo (oder ein Token mit Zugriff auf beide Repos).

2. In `.github/workflows/publish-to-public-releases.yml` die Zeile  
   `PUBLIC_RELEASES_REPO: 'e7a-0-e7a/rhavens_dream_releases'`  
   anpassen (e7a-0-e7a = dein GitHub-Benutzername/Org).

3. Release auslösen:
   - **Mit Tag:** z. B. `git tag v0.1.0 && git push origin v0.1.0` → Workflow baut und veröffentlicht ins öffentliche Repo.
   - **Manuell:** Actions → "Publish to public releases" → "Run workflow", Version z. B. `v0.1.0` eintragen.

Danach erscheinen die Binaries unter **Releases** im **öffentlichen** Repo; der Quellcode bleibt privat.
