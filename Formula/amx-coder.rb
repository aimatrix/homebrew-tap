# frozen_string_literal: true

# Formula for AMX Coder - a multi-agent coding workspace
class AmxCoder < Formula
  desc "Stateless, multi-agent coding workspace for automating coding tasks"
  homepage "https://github.com/aimatrix/amx-coder"
  url "https://public.aimatrix.com/dist/amx-coder/public/amx-coder-1.0.2.tar.gz"
  sha256 "3d9536ee6e30a1cc7753ac2044bdc4b23198baa3f1b87fccbd8e8f4e86f7fed1"
  license "MIT"

  def install
    # Install the prebuilt amx-coder binary
    bin.install "amx-coder.kexe" => "amx-coder"
    # Make executable on Unix-like systems
    chmod "+x", bin/"amx-coder"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "AMX Coder", shell_output("#{bin}/amx-coder --version")

    # Test that help command works
    assert_match "Multi-Agent Coding Workspace", shell_output("#{bin}/amx-coder --help")
  end
end
