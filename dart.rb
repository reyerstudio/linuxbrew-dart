class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.4.0"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "094c862f26ff2f203e5e95801281e9f60eeab3849aed1458f364ee757ed89287"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.0/sdk/dartsdk-linux-ia32-release.zip"
    sha256 "d354d776dd632ab11dabd9842e1d663e976383ee16215e48ee781f27fb18f995"
  end

  devel do
    version "2.5.0-dev.0.0"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.0.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ac6b8c665354d9edbfcc6bb3990c36d7c3d12e8d9c2ff969169a35b07bf9b32d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.0.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5aebb6717abe37c28b532737cb097b3487c6a8339f77e766a4a5b8139d4b55ad"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
