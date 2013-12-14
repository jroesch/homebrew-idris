require 'formula'

class Idris < Formula
  homepage 'www.idris-lang.org'
  url 'https://github.com/jroesch/Idris-dev/archive/v0.9.10.1.tar.gz'
  sha1 '2d426d081d37292c6432bd6c68041b2ad1963b68'

  depends_on 'llvm'
  depends_on 'boehmgc'
  depends_on 'libffi'
  depends_on 'gmp'
  depends_on 'pkg-config'
  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    system 'cabal update'
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
