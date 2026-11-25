# LynShen Homebrew tap

[LynShen CLI](https://github.com/LynShen-Team/Aogiri-CLI)（`lynshen`）的 Homebrew 安装源，macOS 和 Linux 都能用。

```sh
brew install lynshen-team/tap/lynshen
```

用 `brew upgrade lynshen` 更新（`lynshen update` 也会替你运行它）。Linux 上另外装 `bubblewrap`，智能体的 shell 命令在它的沙箱里运行。

不用 Homebrew 的话：`curl -fsSL https://software.lynshen.org/cli/install.sh | bash`（Windows：`irm https://software.lynshen.org/cli/install.ps1 | iex`）。

---

Homebrew tap for LynShen CLI. `Formula/lynshen.rb` is written by `scripts/update_formula.py` from the signed manifest
of the LynShen software library (`https://software.lynshen.org/cli/latest.json`) and downloads the release binaries
from there. `.github/workflows/update.yml` keeps it current: the CLI release runs it right after publishing
(`gh workflow run update.yml -R LynShen-Team/homebrew-tap`), and it also runs every hour. A new version is installed
and tested with brew on macOS and Linux before it is pushed.
