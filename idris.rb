require 'formula'

class Idris < Formula
  homepage 'www.idris-lang.org'
  url 'https://github.com/jroesch/Idris-dev/archive/v0.9.10.1.tar.gz'
  sha1 '2d426d081d37292c6432bd6c68041b2ad1963b68'
 

  depends_on 'apple-gcc42'
  depends_on 'gmp'
  depends_on 'libffi'
  depends_on 'ghc'
  depends_on 'cabal-install'
  depends_on 'llvm' => "--cc=gcc-4.2"
  depends_on 'boehmgc'
  depends_on 'pkg-config'

  def install
    # Compute number of cores
    count = `sysctl hw.ncpu | awk '{print $2}'`
    # Write out build options
    custom = open("custom.mk", "w")
    custom.write("CABALFLAGS += -f LLVM -f FFI -j#{count}")
    custom.close
    # Install
    system 'cabal update'
    system 'cabal install alex' if `which alex` !~ /.*\/alex/
    system 'cabal sandbox init'
    system 'make'
  end

  test do
    install
  end
end
