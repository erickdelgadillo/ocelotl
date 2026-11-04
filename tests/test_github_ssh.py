"""Regression checks for GitHub SSH agent integration and safety."""
from pathlib import Path
import unittest

from jinja2 import Environment

ROOT = Path(__file__).resolve().parents[1]


class GithubSSHTest(unittest.TestCase):
    def test_agent_is_shared_and_on_demand(self):
        template = (ROOT / "roles/shell/templates/zshrc.j2").read_text()
        shell = Environment().from_string(template).render(shell_zsh_plugins=["git"])
        self.assertIn("ssh-add -l", shell)
        self.assertIn("_ocelotl_agent_status == 2", shell)
        self.assertIn("systemctl --user start ocelotl-ssh-agent.service", shell)
        self.assertIn("[[ -o interactive ]]", shell)
        self.assertNotIn("eval $(ssh-agent", shell)

    def test_git_role_does_not_manage_private_keys(self):
        tasks = (ROOT / "roles/git/tasks/main.yml").read_text()
        self.assertIn("AddKeysToAgent yes", tasks)
        self.assertIn('mode: "0700"', tasks)
        self.assertIn('mode: "0600"', tasks)
        self.assertIn("ExecStart=/usr/bin/ssh-agent -D -a %t/", tasks)
        self.assertNotIn("ssh-keygen", tasks)
        self.assertNotIn("IdentityFile", tasks)
        self.assertNotIn("private_key", tasks)

    def test_both_profiles_include_git_before_shell(self):
        for path in ("playbooks/development.yml", "playbooks/workstation.yml"):
            with self.subTest(path=path):
                content = (ROOT / path).read_text()
                self.assertIn("    - git\n    - shell", content)


if __name__ == "__main__":
    unittest.main()
