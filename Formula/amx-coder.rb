# frozen_string_literal: true

# Formula for AMX Coder - a multi-agent coding workspace
class AmxCoder < Formula
  desc "Stateless, multi-agent coding workspace for automating coding tasks"
  homepage "https://github.com/aimatrix/amx-coder"
  url "https://github.com/aimatrix/amx-coder/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "gradle" => :build
  depends_on "openjdk@17" => :build

  def install
    # Set JAVA_HOME for the build
    ENV["JAVA_HOME"] = Formula["openjdk@17"].opt_prefix

    # Determine the target platform for macOS
    target = if Hardware::CPU.arm?
      "macosArm64"
    else
      "macos"
    end

    # Build the native executable for macOS
    system "gradle", "#{target}Binaries", "--no-daemon"

    # Find and install the built executable
    executable_path = "build/bin/#{target}/releaseExecutable/amx-coder.kexe"

    if File.exist?(executable_path)
      bin.install executable_path => "amx-coder"
    else
      odie "Built executable not found at #{executable_path}"
    end
  end

  test do
    # Test that the binary runs and shows version
    assert_match "AMX Coder", shell_output("#{bin}/amx-coder --version")

    # Test that help command works
    assert_match "Multi-Agent Coding Workspace", shell_output("#{bin}/amx-coder --help")
  end
end
