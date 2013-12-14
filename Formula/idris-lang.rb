require 'formula'

class IdrisLang < Formula
  homepage ''
  url 'https://github.com/jroesch/Idris-dev/archive/0.9.9.3.tar.gz'
  sha1 '19f5ff7d1e78da6cd722f1c883a4cd807d2db8b5'

  depends_on 'llvm' => if_gcc ? ["-use-gcc"] : []
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
    install
  end
end
