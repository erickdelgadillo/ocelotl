# Optional local AI with Ollama

Ocelotl can install the Ollama daemon and **one selected local model** on Ubuntu.
This feature is opt-in: it does not run during the default `./bootstrap.sh`
or standard workstation playbook.

## Laptop (RTX 3060 Laptop, 6 GB VRAM)

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml \
  --tags ollama -e ollama_profile=laptop -K
```

Default: `qwen3.5:4b` (roughly 3–4 GB download).

## Workstation (RTX 4070 Ti, confirm VRAM with nvidia-smi)

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml \
  --tags ollama -e ollama_profile=workstation -K
```

Default: `qwen3.5:9b` (roughly 7 GB download).

To override the model, add e.g. `-e ollama_model=qwen3.5:2b`.
No hardware-based automatic selection is performed: the operator chooses a
profile explicitly. This avoids downloading an unexpectedly large model.

## Use and verification

```bash
nvidia-smi
ollama list
ollama ps
ollama run qwen3.5:4b  # on laptop; use qwen3.5:9b on workstation
```

Ollama listens locally by default at `127.0.0.1:11434`.
Do not expose its API to the public Internet without authentication and
appropriate network controls. The role does not alter firewall rules.

The role fetches and runs Ollama's **official online Linux installer** when
Ollama is not already installed; review that installer before opting in.
Subsequent runs skip installation if the executable is present and skip
model downloads if the selected model is already available. It does not
automatically update installed binaries or existing models.

Model downloads and inference require disk space and memory beyond their
published model file sizes. The GPU VRAM amount should be verified
independently: RTX 4070 Ti is usually 12 GB; RTX 4070 Ti SUPER is 16 GB.

This feature is separate from CUDA/NVIDIA driver installation and assumes
the host already has a working driver if GPU acceleration is desired.
