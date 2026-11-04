# GitHub SSH authentication

The `git` role installs Git/OpenSSH and an **on-demand, shared fallback agent** for interactive Zsh terminals. It preserves a working desktop SSH agent, including one with no loaded keys. It never creates, copies, uploads, or stores private keys or tokens.

For each new computer, enroll a per-machine public key with GitHub (only upload the `.pub` file):

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
```

A healthy agent is reused. If no usable socket exists, the shell starts `systemctl --user start ocelotl-ssh-agent.service` and exports a stable per-user socket. The `~/.ssh/config` GitHub entry sets `AddKeysToAgent yes`, so unlocking the key during an SSH authentication can add it to the active agent. You can also run `ssh-add ~/.ssh/id_ed25519` yourself. Keys need unlocking again after reboot.

Diagnostics:

```bash
echo "$SSH_AUTH_SOCK"
ssh-add -l
ssh -vT git@github.com
systemctl --user status ocelotl-ssh-agent.service
```

If a desktop agent is accessible but **refuses signing**, the fallback cannot detect that from `ssh-add -l` alone. Select it explicitly in the affected terminal:

```bash
systemctl --user daemon-reload
systemctl --user start ocelotl-ssh-agent.service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ocelotl-ssh-agent.sock"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
```

No SSH server settings or Git identity are changed. Set `git_ssh_agent_enabled: false` to skip the managed configuration. The agent is never globally enabled at boot; only interactive shells start it when necessary. This feature requires a local systemd user session.
