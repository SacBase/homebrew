class Hwloc1 < Formula
  desc "Portable abstraction of the hierarchical topology of modern architectures"
  homepage "https://www.open-mpi.org/projects/hwloc/"
  version "1.11.13"
  url "https://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.13.tar.bz2"
  sha256 "a4494b7765f517c0990d1c7f09d98cb87755bb6b841e4e2cbfebca1b14bac9c8"

  revision 1

  conflicts_with "hwloc", :because => "homebrew/core formula uses HEAD, which is the v2 branch of hwloc" 

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo" => :optional

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-shared",
                          "--enable-static",
                          "--prefix=#{prefix}",
                          "--without-x"
    system "make", "install"

    pkgshare.install "tests"
  end

  test do
    system ENV.cc, pkgshare/"tests/hwloc_groups.c", "-I#{include}",
                   "-L#{lib}", "-lhwloc", "-o", "test"
    system "./test"
  end
end
