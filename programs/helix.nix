{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "ao";
      keys.insert = {
        j = {
          k = "normal_mode";
        };
      };
      editor = {
        auto-format = true;
        auto-completion = true;
        bufferline = "always";
        statusline = {
          left = ["mode" "spinner"];
          center = ["file-name"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
          separator = "|";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages = {
      language-server = {
        fish-lsp = {
          command = "${pkgs.fish-lsp}/bin/fish-lsp";
          args = [ "start" ];
          config = {
            directories = {
              exclude = [
                "~/.local/share/containers"
                "/var/lib/containers"
                "node_modules"
                ".git"
              ];
            };
          };
        };
        markdown-lsp = {
          command = "${pkgs.zk}/bin/zk";
          args = [ "lsp" ];
          config = {
            directories = {
              exclude = [
                "~/.local/share/containers"
                "/var/lib/containers"
                "node_modules"
                ".git"
              ];
            };
          };
        };
      };
      language = [
        {
          name = "html";
          formatter = {
            command = "prettier";
            args = ["--parser" "html"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["markdown-lsp"];
        }
      ];
    };
  };
}
