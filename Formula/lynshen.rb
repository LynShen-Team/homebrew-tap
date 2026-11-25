# Written by scripts/update_formula.py from https://software.lynshen.org/cli/latest.json
# (.github/workflows/update.yml keeps it current); edits here are overwritten.
class Lynshen < Formula
  desc "Coding agent for the terminal"
  homepage "https://github.com/LynShen-Team/Aogiri-CLI"
  version "0.8.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://software.lynshen.org/cli/0.8.12/lynshen-aarch64-apple-darwin"
      sha256 "5f0f7731991f592404cb70035fdd52ed2a27fd6cfc563e34a9c5b2c6c29f2867"
    end
    on_intel do
      url "https://software.lynshen.org/cli/0.8.12/lynshen-x86_64-apple-darwin"
      sha256 "c1ea2c6e37087a65c08b916d0f51481e1e5f66f0639e214e50767df149ea6b13"
    end
  end

  on_linux do
    on_intel do
      url "https://software.lynshen.org/cli/0.8.12/lynshen-x86_64-unknown-linux-gnu"
      sha256 "4a1b929a3af3a90c55ad8fa2478acd95545e58834b03a58188042ee44a0b9593"
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
    assert_equal "lynshen #{version}", shell_output("#{bin}/lynshen --version").strip
  end
end
