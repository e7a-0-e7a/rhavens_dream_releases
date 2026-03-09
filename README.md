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

Bei der Schnellinstallation werden alle Themes automatisch nach `~/.config/rhavens_dream/themes` gelegt.  
Das aktuell verwendete Theme wird (falls noch nicht gesetzt) in `~/.config/rhavens_dream/theme_path` als vollständiger Pfad abgelegt.

### Zsh-Integration und Theme-Wechsel

Empfohlener Ausschnitt für deine `~/.zshrc`, damit das zuletzt gewählte Theme für alle neuen Terminals gilt:

```bash
export PATH="$HOME/.local/bin:$PATH"

# rhavens_dream prompt – nutzt zuletzt gewähltes Theme aus ~/.config/rhavens_dream/theme_path
_RD_THEME_FILE="$HOME/.config/rhavens_dream/theme_path"
_RD_THEME_DEFAULT="$HOME/.config/rhavens_dream/themes/slimfat.omp.json"
if [[ -r "$_RD_THEME_FILE" ]]; then
  _RD_THEME="$(head -1 "$_RD_THEME_FILE" | tr -d '\n\r')"
  [[ -z "$_RD_THEME" ]] && _RD_THEME="$_RD_THEME_DEFAULT"
else
  _RD_THEME="$_RD_THEME_DEFAULT"
fi
eval "$(rhavens_dream init zsh --config "$_RD_THEME")"

# Theme wechseln und sofort für alle künftigen Terminals speichern:
rdtheme() {
  local dir="$HOME/.config/rhavens_dream"
  mkdir -p "$dir"
  if [[ -n "$1" ]]; then
    printf '%s\n' "$1" > "$dir/theme_path"
    echo "rhavens_dream Theme: $1"
    source ~/.zshrc
  else
    echo "Aktuell: ${_RD_THEME:-$_RD_THEME_DEFAULT}"
    echo "Nutzung: rdtheme /voller/pfad/zu/theme.omp.json"
  fi
}
```

- **Nur im aktuellen Terminal testen (nicht persistent):**

  ```bash
  eval "$(rhavens_dream init zsh --config $HOME/.config/rhavens_dream/themes/if_tea.omp.json)"
  ```

- **Theme dauerhaft für alle neuen Terminals setzen:**

  ```bash
  rdtheme "$HOME/.config/rhavens_dream/themes/slimfat.omp.json"
  ```

**Terminal-Schrift:** Für Icons im Prompt eine **Nerd Font** einstellen (z. B. MesloLGS Nerd Font, Hack Nerd Font).

---

## Versionen

Alle Versionen findest du unter [Releases](https://github.com/e7a-0-e7a/rhavens_dream_releases/releases).  
Dieses Repo enthält keine Quellen – nur Binaries, Themes und diese Anleitung.
