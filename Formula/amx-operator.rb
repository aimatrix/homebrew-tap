# frozen_string_literal: true

# Formula for AMX Operator - a multi-agent coding workspace
class AmxOperator < Formula
  desc "Stateless, multi-agent coding workspace for automating coding tasks"
  homepage "https://github.com/aimatrix/amx-operator-cli"
  url "https://public.aimatrix.com/dist/amx-operator/public/amx-operator-1.0.3.tar.gz"
  sha256 "3d9536ee6e30a1cc7753ac2044bdc4b23198baa3f1b87fccbd8e8f4e86f7fed1"
  license "MIT"

  def install
    # Install the prebuilt amx-operator binary
    bin.install "amx-operator.kexe" => "amx-operator"
    # Make executable on Unix-like systems
    chmod "+x", bin/"amx-operator"
  end

  test do
    # Test that the binary runs and shows version
    assert_match "AMX Operator", shell_output("#{bin}/amx-operator --version")

    # Test that help command works
    assert_match "Multi-Agent Coding Workspace", shell_output("#{bin}/amx-operator --help")
  end
end
