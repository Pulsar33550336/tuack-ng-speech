{
  description = "Tuack-NG 功能与设计分享（Typst + Touying 幻灯片）";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      typix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        typixLib = typix.lib.${system};

        src = ./.;

        # Typst 包不走网络，全部由 typix 从官方 CDN 取；传递依赖也要逐个列出。
        unstable_typstPackages = [
          {
            name = "cetz";
            version = "0.3.4";
            hash = "sha256-5w3UYRUSdi4hCvAjrp9HslzrUw7BhgDdeCiDRHGvqd4=";
          }
          {
            name = "cetz";
            version = "0.5.2";
            hash = "sha256-wttZ+L+VPlTLGKPN/exYXozRjMNdXLShhYVTQt4KV/E=";
          }
          {
            name = "cuti";
            version = "0.4.0";
            hash = "sha256-erKkNXoH/x5WAMTg/bAB1I2AcUd4QCbtBvmHx/zk/Nc=";
          }
          {
            name = "fletcher";
            version = "0.5.8";
            hash = "sha256-kKVp5WN/EbHEz2GCTkr8i8DRiAdqlr4R7EW6drElgWk=";
          }
          {
            name = "octique";
            version = "0.1.1";
            hash = "sha256-Ctpic3vNfrFfonejoS0zpSsKK+rvgGZ0geuMHPF+w30=";
          }
          {
            name = "oxifmt";
            version = "0.2.1";
            hash = "sha256-8PNPa9TGFybMZ1uuJwb5ET0WGIInmIgg8h24BmdfxlU=";
          }
          {
            name = "oxifmt";
            version = "1.0.0";
            hash = "sha256-edTDK5F2xFYWypGpR0dWxwM7IiBd8hKGQ0KArkbpHvI=";
          }
          {
            name = "physica";
            version = "0.9.8";
            hash = "sha256-BGXl33ALR79xQ20JkGclKPrG0nGC+jrxMxHrfv9R9JE=";
          }
          {
            name = "showybox";
            version = "2.0.4";
            hash = "sha256-bxSXdFHHnb/4X26RFwcVaU6VI9VP5BCKCxwt0qBCI80=";
          }
          {
            name = "theorion";
            version = "0.6.0";
            hash = "sha256-w7dcuS5WcsJD7ekTIqHwEkKBtemVdzrl9SMTHZgBitA=";
          }
          {
            name = "touying";
            version = "0.7.4";
            hash = "sha256-G7Z+7o6SQjRa63DCLXcSNAtzohrk4Kljk4pSb4rJfeU=";
          }
          {
            name = "uniwarn";
            version = "0.1.1";
            hash = "sha256-alpI7IgUJfjxDy6KXlPGX2N9KMEHPms/pbxXHRJrmZw=";
          }
          {
            name = "xwysyy";
            version = "0.4.0";
            hash = "sha256-AocBxPB7iPQ/B0ro86zyuLZRxvAYKlvE8MLpMwNLH3c=";
          }
        ];

        # nixpkgs 只打到 lxgw-wenkai / -screen / -tc，没有 GB（国标字形）这一支，
        # 所以直接取上游 release 的两个字重。
        lxgw-wenkai-gb = pkgs.runCommand "lxgw-wenkai-gb-1.522" { } ''
          mkdir -p $out/share/fonts/truetype
          cp ${
            pkgs.fetchurl {
              url = "https://github.com/lxgw/LxgwWenKaiGB/releases/download/v1.522/LXGWWenKaiGB-Regular.ttf";
              hash = "sha256-KVVowTFkgGIQdUOqFZyX3UlWS+eRE2wqv3TK2D66P38=";
            }
          } $out/share/fonts/truetype/LXGWWenKaiGB-Regular.ttf
          cp ${
            pkgs.fetchurl {
              url = "https://github.com/lxgw/LxgwWenKaiGB/releases/download/v1.522/LXGWWenKaiGB-Medium.ttf";
              hash = "sha256-uIXFHsDT8yWXQBOAHfzv2hqboL84XGB89fJYLa+i5as=";
            }
          } $out/share/fonts/truetype/LXGWWenKaiGB-Medium.ttf
        '';

        fontPaths = [
          "${lxgw-wenkai-gb}/share/fonts" # 正文：LXGW WenKai GB（霞鹜文楷 GB）
          "${pkgs.lxgw-wenkai}/share/fonts" # 回退：LXGW WenKai
          "${pkgs.maple-mono.NormalNL-NF-CN}/share/fonts" # 代码：Maple Mono Normal NL NF
          "${pkgs.noto-fonts}/share/fonts" # 末页标题：Noto Serif
        ];

        commonArgs = {
          name = "tuack-ng-speech.pdf";
          typstSource = "main.typ";
          inherit fontPaths;
        };

        build-drv = typixLib.buildTypstProject (
          commonArgs
          // {
            inherit src unstable_typstPackages;
          }
        );

        build-script = typixLib.buildTypstProjectLocal (
          commonArgs
          // {
            inherit src unstable_typstPackages;
          }
        );

        watch-script = typixLib.watchTypstProject commonArgs;
      in
      {
        packages.default = build-drv;

        checks.default = build-drv;

        apps = {
          default = flake-utils.lib.mkApp { drv = build-script; };
          build = flake-utils.lib.mkApp { drv = build-script; };
          watch = flake-utils.lib.mkApp { drv = watch-script; };
        };

        devShells.default = typixLib.devShell {
          inherit fontPaths;
          packages = [
            pkgs.typst
            watch-script
          ];
        };

        formatter = pkgs.nixfmt;
      }
    );
}
