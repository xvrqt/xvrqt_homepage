{
  outputs = _: {
    # Parent flake import the default module to install the site's package, and configure serving it with nginx
    nixosModules = {
      default = {
        lib,
        pkgs,
        config,
        ...
      }: let
        # Convenience
        pkgName = "homepage";
        # Create a new derivation which simply copies the static site contents to the /nix/store
        website = pkgs.stdenv.mkDerivation {
          name = "website-${pkgName}";
          src = ./.;

          installPhase = ''
            cp -r $src/src $out
          '';
        };

        # Check if both the website service is enabled, and this specific site is enabled.
        cfgcheck = config.services.websites.enable && config.services.websites.sites.${pkgName}.enable;
        # Website url
        domain = config.services.websites.sites.${pkgName}.domain;
      in {
        # Create the option to enable this site, and set its domain name
        options = {
          services = {
            websites = {
              sites = {
                homepage = {
                  enable = lib.mkEnableOption "xvrqt homepage (static website)";
                  domain = lib.mkOption {
                    type = lib.types.str;
                    default = "xvrqt.com";
                    example = "gateway.xvrqt.com";
                    description = "Domain name for the website. In the form: sub.domain.tld, domain.tld";
                  };
                };
              };
            };
          };
        };

        config = {
          # Add the website to the system's packages
          environment.systemPackages = [website];

          # Configure a virtual host on nginx
          services.nginx.virtualHosts.${domain} = lib.mkIf cfgcheck {
            forceSSL = true;
            enableACME = true;
            acmeRoot = null;
            extraConfig = ''
              charset utf-8;
              etag on;
              index index.html;
              http2_push_preload on;
              expires $expires;
            '';
            locations."/" = {
              root = "${website}";
              extraConfig = ''
                try_files $uri $uri/ =404;

                http2_push /styles.css;
                http2_push /images/xvrqt.webp;
                http2_push /images/xvrqt.png;
                http2_push /images/title/xvrqt@3x.webp;
                http2_push /images/title/xvrqt@3x.png;
                http2_push /images/bg@2x.png;
              '';
            };
          };
        };
      };
    };
  };
}
