# Optional AI desktop apps

An opt-in Ansible role for Ubuntu desktop installations.

- **ChatGPT:** official web launcher at https://chatgpt.com/ (not the native client).
- **Claude:** native Linux beta installed from Anthropic's signed APT repository.
- **Perplexity:** official web launcher at https://www.perplexity.ai/ (not a browser-installed PWA).

All three are individually configurable with `ai_apps_chatgpt`,
`ai_apps_claude` and `ai_apps_perplexity` (boolean variables).

Run from the repository root:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/ai-apps.yml -K
```

For example, to skip Claude:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/ai-apps.yml -K -e ai_apps_claude=false
```

The role is **not** included in the default/full bootstrap, so normal Ocelotl
provisioning remains unchanged. No tokens, credentials, API keys or browser
sessions are managed.

Claude's repository key fingerprint is checked against the published Anthropic
fingerprint before enabling the repository. Verify on the official page:
https://support.claude.com/en/articles/10065433-install-claude-desktop

### Limitations

The two web launchers use `xdg-open`, opening the configured default browser.
They do not isolate browser profiles or install a PWA. An official ChatGPT
Linux native preview exists, but automated native installation should be added
only after verifying a stable signed package source. Claude Desktop is beta.

Test on the laptop before applying it to the scientific workstation. Run twice
and confirm the second play introduces no unnecessary changes. If the browser
already has a manually-installed PWA, this role will create an additional
launcher rather than replacing it.
