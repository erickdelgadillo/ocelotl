# AI installation profile

Ocelotl separates local AI inference (Ollama) from cloud AI desktop
clients (the existing `ai_apps` role).

## Installation

```bash
./bootstrap.sh ai
```

Installs Ollama and one locally chosen model, Claude Desktop through the
configured APT repository, and ChatGPT/Perplexity web launchers.

The existing `./bootstrap.sh full` is **unchanged by default**. Explicitly
enable the two AI roles with:

```bash
OCELOTL_ENABLE_AI=1 ./bootstrap.sh full
```

This does not download a model. To opt into the multi-GB model download:

```bash
OCELOTL_ENABLE_AI=1 OCELOTL_PULL_MODEL=1 ./bootstrap.sh full
```

## Hardware-based model selection

The Ollama role supports `ollama_profile=auto` (default) and queries
`nvidia-smi` for NVIDIA GPU total memory:

- 12 GB or more: `qwen3.5:9b`
- 6 GB to less than 12 GB: `qwen3.5:4b`
- Below 6 GB, absent driver, or unavailable NVIDIA GPU: `qwen3.5:2b`

VRAM is total reported device memory, not unallocated/free VRAM.
The role does not install NVIDIA GPU drivers. On machines with multiple GPUs,
it currently uses the first reported GPU.

Override model selection with Ansible:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/ai.yml \
  -e ollama_profile=cpu -e ollama_model=qwen3.5:2b -K
```

To skip model weights when running the `ai` playbook directly, pass
`-e ollama_pull_model=false`.

## Tests and limitations

```bash
ansible-playbook -i inventory/localhost.ini playbooks/ai.yml --syntax-check
ansible-lint
```

Run provisioning twice on a real Ubuntu machine and inspect the second
`PLAY RECAP` for `changed=0`. The CI tests syntax and lint for the
AI playbook, but cannot safely provision third-party GUI software or download
large models on GitHub's hosted runner. The official Ollama installer is executed when the executable, the `ollama` system user, or the systemd unit is absent. Interrupted installs are repaired on the next run. Installer download and execution each have at most three attempts; a failed repair stops provisioning. Inspect the remote script before opting in. The upstream binary archive is downloaded by that installer, so Ocelotl cannot independently verify its checksum.
No API keys, model sessions, or credentials are stored.


## Recovery test (real Ubuntu host)

1. After installing Ollama, run `./bootstrap.sh ai` again and confirm `changed=0`.
2. To simulate a missing service **only on a disposable test host**, remove/disable its unit, then rerun the AI profile; verify that the official installer restores the service and user.
3. Confirm `systemctl is-active ollama`, `id ollama`, and `ollama list`.
4. Simulate a download interruption only in an isolated test environment; verify bounded retries and failure rather than a falsely successful install.

The hosted CI syntax-checks AI provisioning but does not run these destructive or multi-GB integration scenarios.
