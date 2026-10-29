# Shell role

Installs Zsh, Oh My Zsh, terminal utilities and pinned plugins; makes Zsh the login shell.

**Important:** Ocelotl manages `~/.zshrc` (with an Ansible backup). Put personal settings in `~/.zshrc.local`, which Ocelotl does not overwrite. Existing Conda initialization is loaded when detected.

Check in a new terminal:

```bash
echo "$SHELL"
zsh --version
command -v conda
```

See [defaults](defaults/main.yml) and [template](templates/zshrc.j2) for exact configuration.
