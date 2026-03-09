# rhavens_dream – Installation & Themes

Dieses Repository stellt **fertige Binaries und Themes** für `rhavens_dream` bereit.  
Der Quellcode lebt in einem privaten Repository; hier findest du nur Downloads und Nutzungshinweise.

---

## Schnellinstallation (empfohlen)

**Linux / macOS (Bash/Zsh):**

```bash
curl -sSL https://raw.githubusercontent.com/e7a-0-e7a/rhavens_dream_releases/main/install.sh | bash
```

Das Skript:

- lädt die passende Binary für dein System herunter und installiert sie nach `~/.local/bin` (oder `~/bin`) und  
- installiert die mitgelieferten Themes nach `~/.config/rhavens_dream/themes` und setzt – falls noch keines gewählt wurde – ein Default-Theme.

Stelle sicher, dass `~/.local/bin` in deinem `PATH` liegt, z. B. in `~/.zshrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

---

## Manueller Download

1. Öffne [Releases](https://github.com/e7a-0-e7a/rhavens_dream_releases/releases).
2. Lade die passende Datei für dein System herunter:

   | System                | Datei (Beispiel)                    |
   |-----------------------|-------------------------------------|
   | macOS (Apple Silicon) | `rhavens_dream-aarch64-apple-darwin`   |
   | macOS (Intel)         | `rhavens_dream-x86_64-apple-darwin`   |
   | Linux (x86_64)        | `rhavens_dream-x86_64-unknown-linux-gnu` |
   | Windows (x64)         | `rhavens_dream-x86_64-pc-windows-msvc.exe` |

3. Datei ausführbar machen (Unix): `chmod +x rhavens_dream-...`
4. In einen Ordner im PATH legen (z. B. `~/.local/bin` oder `/usr/local/bin`).

Optional kannst du die Theme-Dateien (`*.omp.json`) ebenfalls manuell aus dem Release herunterladen und nach  
`~/.config/rhavens_dream/themes` kopieren.

---

## Themes

Bei der Schnellinstallation werden Themes automatisch nach `~/.config/rhavens_dream/themes` gelegt.  
Beispiele für mitgelieferte Themes:

- `slimfat.omp.json`
- `if_tea.omp.json`
- `blueish.omp.json`

Das aktuell verwendete Theme wird (falls noch nicht gesetzt) in `~/.config/rhavens_dream/theme_path` als vollständiger Pfad abgelegt.

**Shell-Integration (z. B. Zsh):**

```bash
eval "$(rhavens_dream init zsh --config $HOME/.config/rhavens_dream/themes/slimfat.omp.json)"
```

oder, wenn du die Theme-Auswahl wie im privaten Setup nutzt, kannst du `theme_path` auslesen:

```bash
THEME_PATH_FILE="$HOME/.config/rhavens_dream/theme_path"
if [ -r "$THEME_PATH_FILE" ]; then
  eval "$(rhavens_dream init zsh --config "$(cat "$THEME_PATH_FILE")")"
fi
```

**Terminal-Schrift:** Für Icons im Prompt eine **Nerd Font** einstellen (z. B. MesloLGS Nerd Font, Hack Nerd Font).

---

## Versionen

Alle Versionen findest du unter [Releases](https://github.com/e7a-0-e7a/rhavens_dream_releases/releases).  
Dieses Repo enthält keine Quellen – nur Binaries, Themes und diese Anleitung.
