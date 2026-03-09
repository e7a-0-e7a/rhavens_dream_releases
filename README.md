# rhavens_dream – Install

Binaries und Install-Anleitung für **rhavens_dream** (Prompt-Renderer).  
Kein Quellcode – nur Downloads und Nutzung.

---

## Schnellinstallation (empfohlen)

**Linux / macOS (Bash/Zsh):**

```bash
curl -sSL https://raw.githubusercontent.com/e7a-0-e7a/rhavens_dream_releases/main/install.sh | bash
```

Ersetze `e7a-0-e7a` durch deinen GitHub-Benutzernamen (oder die Organisation), unter der das Repo `rhavens_dream_releases` liegt.

Das Skript legt die Binary in `~/.local/bin` (oder `~/bin`) und fügt den Pfad ggf. in deiner Shell-Konfiguration hinzu.

---

## Manueller Download

1. Öffne [Releases](https://github.com/e7a-0-e7a/rhavens_dream_releases/releases).
2. Lade die passende Datei für dein System herunter:

   | System        | Datei (Beispiel)                    |
   |---------------|-------------------------------------|
   | macOS (Apple Silicon) | `rhavens_dream-aarch64-apple-darwin`   |
   | macOS (Intel) | `rhavens_dream-x86_64-apple-darwin`   |
   | Linux (x86_64)| `rhavens_dream-x86_64-unknown-linux-gnu` |
   | Windows (x64) | `rhavens_dream-x86_64-pc-windows-msvc.exe` |

3. Datei ausführbar machen (Unix): `chmod +x rhavens_dream-...`
4. In einen Ordner im PATH legen (z. B. `~/.local/bin` oder `/usr/local/bin`).

---

## Nutzung nach der Installation

**Shell-Integration (z. B. Zsh):**

```bash
# Theme-Datei z. B. herunterladen oder lokal haben, dann:
eval "$(rhavens_dream init zsh --config /pfad/zu/theme.omp.json)"
```

In die `~/.zshrc` eintragen, damit es in jeder Session geladen wird.

**Terminal-Schrift:** Für Icons im Prompt eine **Nerd Font** einstellen (z. B. MesloLGS Nerd Font, Hack Nerd Font).

---

## Versionen

Alle Versionen findest du unter [Releases](https://github.com/e7a-0-e7a/rhavens_dream_releases/releases).  
Kein Quellcode in diesem Repo – nur Binaries und diese Anleitung.
