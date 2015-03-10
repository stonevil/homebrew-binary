class Walter < Formula
  homepage "https://github.com/Walter-cd/Walter"
  version "1.0.0"

  if Hardware.is_64_bit?
    url "https://github.com/walter-cd/walter/releases/download/v#{version}/walter_darwin_amd64.zip"
    sha256 "25d0fe4fc1e9a2301aaf8643570f23f6568e2c1241ca9ff313b623ad4715bfcd"
  else
    url "https://github.com/walter-cd/walter/releases/download/v#{version}/walter_darwin_386.zip"
    sha256 "2855c0b4fe95d5d075f9acaf2147a5b7ea8d1579a0bd7dfeef9bd235ddfaf18b"
  end

  depends_on :arch => :intel

  def install
    if Hardware.is_64_bit?
      bin.install "walter" => "walter"
    else
      bin.install "walter" => "walter"
    end
  end

  test do
    minimal = testpath/"pipeline.yml"
    minimal.write <<-EOS.undent
      pipeline:
          - stage_name: command_stage_1
            command: echo "hello, world"
            run_after:
                -  stage_name: command_stage_2_group_1
                  command: echo "hello, world, command_stage_2_group_1" && sleep 1
                -  stage_name: command_stage_3_group_1
                  command: echo "hello, world, command_stage_3_group_1"&& sleep 0.2
                  run_after:
                        -  stage_name: command_stage_3_group_2
                          command: echo "hello, world, command_stage_3_group_2" && sleep 0.4
          - stage_name: command_stage_4
            command: echo "hello, world"
          - stage_name: command_stage_5
            command: echo "hello, world, command_stage_3_group_1"
    EOS
    system "#{bin}/walter", "-c", minimal
  end
end
