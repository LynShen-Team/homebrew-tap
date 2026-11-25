"""Writes Formula/lynshen.rb for the newest LynShen CLI release.

    python3 scripts/update_formula.py [manifest-url]

Reads the software library's manifest (https://software.lynshen.org/cli/latest.json):
its version and the sha256 of each platform's binary. The formula downloads
those binaries from the same library. Prints the version.
"""
import json
import re
import sys
import urllib.request
from pathlib import Path

MANIFEST = 'https://software.lynshen.org/cli/latest.json'
BINARIES = {
    'mac_arm': 'lynshen-aarch64-apple-darwin',
    'mac_intel': 'lynshen-x86_64-apple-darwin',
    'linux_intel': 'lynshen-x86_64-unknown-linux-gnu',
}
FORMULA = '''# Written by scripts/update_formula.py from {manifest}
# (.github/workflows/update.yml keeps it current); edits here are overwritten.
class Lynshen < Formula
  desc "Coding agent for the terminal"
  homepage "https://github.com/LynShen-Team/Aogiri-CLI"
  version "{version}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "{base}/{version}/{mac_arm}"
      sha256 "{mac_arm_sha}"
    end
    on_intel do
      url "{base}/{version}/{mac_intel}"
      sha256 "{mac_intel_sha}"
    end
  end

  on_linux do
    on_intel do
      url "{base}/{version}/{linux_intel}"
      sha256 "{linux_intel_sha}"
    end
  end

  def install
    bin.install Dir["lynshen-*"].first => "lynshen"
  end

  def caveats
    return unless OS.linux?

    <<~EOS
      lynshen runs shell commands in a bubblewrap sandbox. Install bubblewrap
      with your system's package manager, for example:
        sudo apt install bubblewrap
    EOS
  end

  test do
    assert_equal "lynshen #{{version}}", shell_output("#{{bin}}/lynshen --version").strip
  end
end
'''


def main():
    manifest_url = sys.argv[1] if len(sys.argv) > 1 else MANIFEST
    with urllib.request.urlopen(manifest_url, timeout=30) as response:
        manifest = json.load(response)
    release = json.loads(manifest['release'])
    version = release['version']
    if release.get('product') != 'cli' or not re.fullmatch(r'\d+\.\d+\.\d+', version):
        raise SystemExit(f'{manifest_url} is not a CLI release')
    sha = {entry['name']: entry['sha256'] for entry in release['files']}
    values = {'manifest': manifest_url, 'base': manifest_url.rsplit('/', 1)[0], 'version': version}
    for key, name in BINARIES.items():
        digest = sha.get(name, '')
        if not re.fullmatch(r'[0-9a-f]{64}', digest):
            raise SystemExit(f'release {version} has no sha256 for {name}')
        values[key] = name
        values[f'{key}_sha'] = digest
    path = Path(__file__).resolve().parent.parent / 'Formula' / 'lynshen.rb'
    path.write_text(FORMULA.format(**values))
    print(version)


if __name__ == '__main__':
    main()
