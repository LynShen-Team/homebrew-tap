# Written by scripts/update_formula.py from https://software.lynshen.org/cli/latest.json
# (.github/workflows/update.yml keeps it current); edits here are overwritten.
class Lynshen < Formula
  desc "Coding agent for the terminal"
  homepage "https://github.com/LynShen-Team/Aogiri-CLI"
  version "0.8.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://software.lynshen.org/cli/0.8.10/lynshen-aarch64-apple-darwin"
      sha256 "11f7f918eb4ea8a92141c389e1388509379d0838ebe6a8f37a2785740c28c9e9"
    end
    on_intel do
      url "https://software.lynshen.org/cli/0.8.10/lynshen-x86_64-apple-darwin"
      sha256 "712bfd7a7e6e9e2bdd7b9323b3d2627ec5dc6140429a61c6e4a810b83cf50157"
    end
  end

  on_linux do
    on_intel do
      url "https://software.lynshen.org/cli/0.8.10/lynshen-x86_64-unknown-linux-gnu"
      sha256 "11206800813a94d6e32206b75f1cfe175c66fa2f09b3002a3b7a95181f96db4c"
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
