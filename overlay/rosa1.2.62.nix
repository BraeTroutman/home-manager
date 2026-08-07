{ buildGoModule, fetchFromGitHub, makeWrapper }:

buildGoModule rec {
  pname = "rosa-v1.2.62";
  version = "v1.2.62";

  src = fetchFromGitHub {
    owner = "openshift";
    repo = "rosa";
    rev = "${version}";
    sha256 = "sha256-vBIh4drMBd6BXkwmnBFzHuayLmgAX9DtXVENAGnJghY=";
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
    mv $out/bin/rosa $out/bin/rosa-v1.2.62
  '';
}
