require 'formula'

class IdrisLang < Formula
  homepage ''
  url 'https://github.com/jroesch/Idris-dev/archive/0.9.9.3.tar.gz'
  sha1 '19f5ff7d1e78da6cd722f1c883a4cd807d2db8b5'

  depends_on 'llvm' #=> if_gcc ? "-use-gcc" : ""
  depends_on 'boehmgc'
  depends_on 'libffi'
  depends_on 'gmp'
  depends_on 'pkg-config'
  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    system 'cabal install alex' if `which alex` =~ /alex/
    system 'make'
  end

  def if_gcc
    ghc_info = eval(`ghc --info`.gsub("(", "[").gsub(")", "]").gsub("\n", " "))
    ghc_info[2][1] =~ /gcc/
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test Idris-dev`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
