{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "backplane-cli";
  version = "0.1.45";

  src = fetchFromGitHub {
    owner = "openshift";
    repo = "backplane-cli";
    rev = "v${version}";
    sha256 = "sha256-EQvvOGSofOSMsSNQjx1CLP41fjt8QilMmML9DUpe8E0=";
  };

  CGO_ENABLED = 0;
  doCheck = false;

  ldflags = [
    "-s" "-w"
    "-X github.com/openshift/backplane-cli/pkg/info.Version=${version}"
  ];

  vendorHash = "sha256-C7Vo117IHEihmTevTj45NduObZtiMRuirmDSex6Lvr0=";

  subPackages = [ "cmd/ocm-backplane" ];
}
