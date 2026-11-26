# Written by scripts/update_formula.py from https://software.lynshen.org/cli/latest.json
# (.github/workflows/update.yml keeps it current); edits here are overwritten.
class Lynshen < Formula
  desc "Coding agent for the terminal"
  homepage "https://github.com/LynShen-Team/Aogiri-CLI"
  version "0.8.14"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://software.lynshen.org/cli/0.8.14/lynshen-aarch64-apple-darwin"
      sha256 "a1977d2dfb2c3149977ef9bc33691114834dc66a3f56609fad5cf4bcf08a935e"
    end
    on_intel do
      url "https://software.lynshen.org/cli/0.8.14/lynshen-x86_64-apple-darwin"
      sha256 "4f6f306895b31cbf327faf72548d607a56adc07310bc5d6041da81411b735c9e"
    end
  end

  on_linux do
    on_intel do
      url "https://software.lynshen.org/cli/0.8.14/lynshen-x86_64-unknown-linux-gnu"
      sha256 "35402e4058e3d9801768e48439e672004c6b0d5f619238dd2679122b69ff7048"
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
