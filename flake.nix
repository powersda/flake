{
    description = "powrNix system configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
        home-manager = {
            url = github:nix-community/home-manager;
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, hyprland }:
    let
        user = "pwrhs";
        location = "$HOME/.nix-config";
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        theme = import ./home-manager/theme.nix;
    in
    {
        nixosConfigurations = {
            powrNix = nixpkgs.lib.nixosSystem {
                inherit pkgs system;
                specialArgs = { inherit system hyprland; };
                modules = [
                    ./nixos/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.${user} = import ./home-manager/home.nix;
                            extraSpecialArgs = { inherit theme; };
                        };
                    }
                ];
            };
        };
    };
}
