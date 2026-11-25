# Written by scripts/update_formula.py from https://software.lynshen.org/cli/latest.json
# (.github/workflows/update.yml keeps it current); edits here are overwritten.
class Lynshen < Formula
  desc "Coding agent for the terminal"
  homepage "https://github.com/LynShen-Team/Aogiri-CLI"
  version "0.8.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://software.lynshen.org/cli/0.8.11/lynshen-aarch64-apple-darwin"
      sha256 "88289a0b78db4fff360537d5a8e3d71df49d73eba5b87640cf592fc729f40e8c"
    end
    on_intel do
      url "https://software.lynshen.org/cli/0.8.11/lynshen-x86_64-apple-darwin"
      sha256 "1ffe933c224068238af78da077e4e57237b7b9eac57fa5bc5a08e0a46d9c551a"
    end
  end

  on_linux do
    on_intel do
      url "https://software.lynshen.org/cli/0.8.11/lynshen-x86_64-unknown-linux-gnu"
      sha256 "08d3d12b21defd620513a598f1132f3017c3ec6e72b01ff36582014a205cc425"
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
