# Shell role

Configures a Zsh-based interactive shell environment for the Ansible target
user.

The role installs command-line tools, deploys Oh My Zsh and selected plugins at
pinned Git revisions, renders an Ocelotl-managed `.zshrc`, and changes the
target user's login shell to `/usr/bin/zsh`.

## Responsibilities

The role:

- Installs `zsh`, `git`, `curl`, `fzf`, `tmux`, `ripgrep`, and `bat` through
  APT.
- Clones Oh My Zsh into the configured user directory at a pinned commit.
- Clones `zsh-autosuggestions` and `zsh-syntax-highlighting` into Oh My Zsh's
  custom plugin directory at pinned commits.
- Renders the `zshrc.j2` template as `~/.zshrc`.
- Creates an Ansible backup before replacing an existing `.zshrc`.
- Sets the configured user's login shell to `/usr/bin/zsh`.

## Default variables

| Variable | Default | Description |
| --- | --- | --- |
| `shell_user` | `{{ ansible_user_id }}` | User whose login shell is changed to Zsh. |
| `shell_home` | `{{ ansible_env.HOME }}` | Home directory where Oh My Zsh and `.zshrc` are managed. |
| `shell_ohmyzsh_dir` | `{{ shell_home }}/.oh-my-zsh` | Installation directory for Oh My Zsh. |
| `shell_zsh_plugins` | `git`, `history`, `zsh-autosuggestions`, `zsh-syntax-highlighting` | Plugins enabled by the rendered Zsh configuration. |

Oh My Zsh and the two custom plugins are intentionally pinned to Git commit
identifiers in `tasks/main.yml`. This makes the managed shell environment more
stable than following the upstream default branch.

## Managed files and directories

| Path | Management behaviour |
| --- | --- |
| `{{ shell_ohmyzsh_dir }}` | Cloned from the Oh My Zsh repository. |
| `{{ shell_ohmyzsh_dir }}/custom/plugins/zsh-autosuggestions` | Cloned from the zsh-autosuggestions repository. |
| `{{ shell_ohmyzsh_dir }}/custom/plugins/zsh-syntax-highlighting` | Cloned from the zsh-syntax-highlighting repository. |
| `{{ shell_home }}/.zshrc` | Rendered from `templates/zshrc.j2` with mode `0644`; Ansible creates a backup when replacing an existing file. |

## Example playbook

```yaml
---
- name: Configure an interactive shell
  hosts: localhost
  connection: local

  roles:
    - role: shell
```

Override the target user and home directory only when provisioning a clearly
defined non-default account:

```yaml
shell_user: researcher
shell_home: /home/researcher
```

Do not place aliases containing private paths, credentials, access tokens, or
personal configuration directly in public role defaults.

## Validation

After the role completes, start a new login session or open a new terminal.
Then verify:

```bash
echo "$SHELL"
zsh --version
git --version
fzf --version
tmux -V
rg --version
bat --version
```

Confirm that Oh My Zsh and the managed plugins are present:

```bash
test -d "$HOME/.oh-my-zsh"
test -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
test -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
```

You can check the active Zsh configuration with:

```bash
sed -n '1,240p' "$HOME/.zshrc"
```

## Important behaviour

The role manages `~/.zshrc` and changes the user's login shell to
`/usr/bin/zsh`. Existing custom Zsh configuration is backed up by Ansible, but
the rendered Ocelotl configuration becomes the active `.zshrc`.

Review `templates/zshrc.j2` before running this role on a workstation with an
existing customized Zsh setup.

## Idempotence

APT packages are managed with `state: present`. Oh My Zsh and plugin
repositories are checked out at fixed commit revisions. The `.zshrc` template
is rewritten only when its rendered content changes, and the user shell is set
only when it differs from `/usr/bin/zsh`.
