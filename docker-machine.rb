require 'formula'

class DockerMachine < Formula
  homepage 'https://github.com/docker/machine'
  version '0.1.0-rc5'

  if Hardware.is_64_bit?
    url "https://github.com/docker/machine/releases/download/v#{version}/docker-machine_darwin-amd64"
    sha256 'c04251529cdfcd51ac1e3ebd19cf117e978f3e5d6c117b7b591b0c9768d15e76'
  else
    url "https://github.com/docker/machine/releases/download/v#{version}/docker-machine_darwin-386"
    sha256 '565498bea38b993d2c15f701e6d845bbbb4b18c27478b7f07c32e6c6c41c45af'
  end

  depends_on :arch => :intel

  def install
    if Hardware.is_64_bit?
      bin.install "docker-machine_darwin-amd64" => "docker-machine"
    else
      bin.install "docker-machine_darwin-386" => "docker-machine"
    end
  end

  test do
    system "#{bin}/docker-machine", "-h"
  end
end
