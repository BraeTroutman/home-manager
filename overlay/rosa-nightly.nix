{ buildGoModule, fetchFromGitHub, makeWrapper }:

buildGoModule rec {
  pname = "rosa-nightly";
  version = "6a9c1574f103e392f030e98b8c52384f6d01a371";

  src = fetchFromGitHub {
    owner = "openshift";
    repo = "rosa";
    rev = "${version}";
    sha256 = "sha256-CPJdaymA6poUQYqWZwnagTqLCChdDj852Y1l6qnxXZ8=";
  };

  nativeBuildInputs = [ makeWrapper ];

  env.CGO_ENABLED = 0;
  doCheck = false;

  ldflags = [
    "-s" "-w"
    "-X github.com/openshift/rosa/pkg/info.Version=${version}"
  ];
  vendorHash = null;

  subPackages = [ "cmd/rosa" ];

  postInstall = ''
    mv $out/bin/rosa $out/bin/rosa-nightly
  '';
}
