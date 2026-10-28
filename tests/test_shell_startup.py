"""Regression tests for the Ocelotl-managed Zsh startup file."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest

from jinja2 import Environment

ROOT = Path(__file__).resolve().parents[1]
TEMPLATE = ROOT / "roles/shell/templates/zshrc.j2"


class ZshStartupTest(unittest.TestCase):
    def test_system_path_and_conda_activation_survive_bad_inherited_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            home = Path(tmp)
            ohmyzsh = home / ".oh-my-zsh"
            ohmyzsh.mkdir()
            (ohmyzsh / "oh-my-zsh.sh").write_text("# mock\n")
            conda = home / "miniforge3/etc/profile.d"
            conda.mkdir(parents=True)
            (conda / "conda.sh").write_text(
                "conda() { [[ \"$1\" == activate && \"$2\" == base ]]; }\n"
            )
            (home / ".zshrc.local").write_text(
                "export OCELOTL_LOCAL_SOURCED=yes\n"
            )
            rendered = Environment().from_string(
                TEMPLATE.read_text()
            ).render(shell_zsh_plugins=["git", "history"])
            (home / ".zshrc").write_text(rendered)
            env = dict(os.environ, HOME=str(home), PATH="/usr/bin:/bin")
            command = (
                "path=( /not-a-command ); "
                "source \"$HOME/.zshrc\"; "
                "command -v dirname >/dev/null && "
                "command -v stat >/dev/null && "
                "command -v head >/dev/null && "
                "conda activate base && "
                "[[ \"$OCELOTL_LOCAL_SOURCED\" == yes ]]"
            )
            result = subprocess.run(
                ["/usr/bin/zsh", "-f", "-c", command],
                env=env, text=True, capture_output=True, check=False,
            )
            self.assertEqual(result.returncode, 0, result.stderr)

    def test_no_conda_install_does_not_break_shell(self):
        with tempfile.TemporaryDirectory() as tmp:
            home = Path(tmp)
            ohmyzsh = home / ".oh-my-zsh"
            ohmyzsh.mkdir()
            (ohmyzsh / "oh-my-zsh.sh").write_text("# mock\n")
            rendered = Environment().from_string(
                TEMPLATE.read_text()
            ).render(shell_zsh_plugins=["git"])
            (home / ".zshrc").write_text(rendered)
            result = subprocess.run(
                ["/usr/bin/zsh", "-f", "-c",
                 'source "$HOME/.zshrc"; command -v dirname >/dev/null'],
                env=dict(os.environ, HOME=str(home), PATH="/usr/bin:/bin"),
                text=True, capture_output=True, check=False,
            )
            self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == "__main__":
    unittest.main()
