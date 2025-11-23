{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gabi-cli";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "app-sre";
    repo = "gabi-cli";
    rev = "v${version}";
    sha256 = "sha256-ozf3BIC/ppXqkU/1GwMdtnieTQt9ELsSTfxEZ8T9aYQ=";
  };

  vendorHash = "sha256-+QCrRu8jsQ6yJICE+g2FRE0R0rXyMyLLjz81UINSIDo=";

  meta = {
    description = "CLI tool to simplify configuration and usage of Gabi";
    homepage = "https://github.com/app-sre/gabi-cli";
  };
}
