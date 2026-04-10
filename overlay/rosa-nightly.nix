{ buildGoModule, fetchFromGitHub, makeWrapper }:

buildGoModule rec {
  pname = "rosa-nightly";
  version = "b81b9e95acd8758bd973c0753d8edb92b2e95bad";

  src = fetchFromGitHub {
    owner = "openshift";
    repo = "rosa";
    rev = "${version}";
    sha256 = "sha256-aHRWCYuVzsmqTnuLgz1nqHeMTpE3O1YIf3sf2ee8uyc=";
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
