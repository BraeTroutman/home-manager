{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "backplane-cli";
  version = "5ce4c449415de9fc035e5eb20894d13cface4286";

  src = fetchFromGitHub {
    owner = "openshift";
    repo = "backplane-cli";
    rev = "${version}";
    sha256 = "sha256-EQvvOGSofOSMsSNQjx1CLP41fjt8QilMmML9DUpe8E0=";
  };

  env.CGO_ENABLED = 0;
  doCheck = false;

  ldflags = [
    "-s" "-w"
    "-X github.com/openshift/backplane-cli/pkg/info.Version=${version}"
  ];

  vendorHash = "sha256-C7Vo117IHEihmTevTj45NduObZtiMRuirmDSex6Lvr0=";

  subPackages = [ "cmd/ocm-backplane" ];
}
