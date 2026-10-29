# Inventory

[localhost.ini](localhost.ini) targets the local workstation. Run commands from the repository root:

```bash
ansible -i inventory/localhost.ini all -m ping
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml
```

Keep machine-specific inventories and credentials out of Git. See [installation](../README.md).
