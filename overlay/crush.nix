{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "brush";
  version = "2d8b1ff7072afcc4732ea0af56a2045527502917";

  src = fetchFromGitHub {
    owner = "BraeTroutman";
    repo = "crush";
    rev = "${version}";
    sha256 = "sha256-hl4cQBMjlrPwBmqxBjppof1/+2etyYLvoWmEw2Ri2pc=";
  };

  env.CGO_ENABLED = 0;
  doCheck = false;

  vendorHash = "sha256-qXR+z31tZ3FWclBUWkBF0k/F463iKSGZ6dCgJMBcWi8=";

  subPackages = [ "." ];

  postInstall = ''
    mv $out/bin/crush $out/bin/brush
  '';
}
