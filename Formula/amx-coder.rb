# frozen_string_literal: true

# Formula for AMX Coder - a multi-agent coding workspace
class AmxCoder < Formula
  desc "Stateless, multi-agent coding workspace for automating coding tasks"
  homepage "https://public.aimatrix.com/dist/amx-coder/public/"
  url "https://public.aimatrix.com/dist/amx-coder/public/amx-coder-1.0.2.tar.gz"
  sha256 "8f3a9c4dc03a72ccbc58f4de3ea5af707b7f12534043f3301acdd46f7d463f3d"
  license "MIT"

  depends_on "openjdk@17" => :build
  depends_on "gradle" => :build

  def install
    ENV["JAVA_HOME"] = Formula["openjdk@17"].opt_prefix
    
    # Clean any existing build artifacts
    system "./gradlew", "clean", "--no-daemon"
    
    # Build for current platform
    if Hardware::CPU.arm?
      system "./gradlew", "linkReleaseExecutableMacosArm64", "--no-daemon"
      if File.exist?("build/bin/macosArm64/releaseExecutable/amx-coder.kexe")
        bin.install "build/bin/macosArm64/releaseExecutable/amx-coder.kexe" => "amx-coder"
      else
        odie "Build failed: macOS ARM64 binary not found"
      end
    else
      system "./gradlew", "linkReleaseExecutableMacosX64", "--no-daemon"
      if File.exist?("build/bin/macosX64/releaseExecutable/amx-coder.kexe")
        bin.install "build/bin/macosX64/releaseExecutable/amx-coder.kexe" => "amx-coder"
      else
        # Try the old path for Intel Macs
        system "./gradlew", "linkReleaseExecutableMacos", "--no-daemon"
        if File.exist?("build/bin/macos/releaseExecutable/amx-coder.kexe")
          bin.install "build/bin/macos/releaseExecutable/amx-coder.kexe" => "amx-coder"
        else
          odie "Build failed: macOS x64 binary not found"
        end
      end
    end
  end

  test do
    assert_match "AMX Coder", shell_output("#{bin}/amx-coder --version")
    assert_match "Multi-Agent Coding Workspace", shell_output("#{bin}/amx-coder --help")
  end
end
