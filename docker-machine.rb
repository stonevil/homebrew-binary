class DockerMachine < Formula
  homepage "https://github.com/docker/machine"
  version "0.1.0"

  if Hardware.is_64_bit?
    url "https://github.com/docker/machine/releases/download/v#{version}/docker-machine_darwin-amd64"
    sha256 "9915d88f779915aa7f1d7ba2537433b15665030574d61b9e348dd1f7397606c4"
  else
    url "https://github.com/docker/machine/releases/download/v#{version}/docker-machine_darwin-386"
    sha256 "bb00460490c3b5a4ee2e74676d1195599f769e6d8beaf6dd3609a27316f81e94"
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
