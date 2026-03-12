{
  description = "Enter The Wired";

  inputs = {
    # Pinned for reproducibility. Update this revision explicitly when needed.
    nixpkgs.url = "github:NixOS/nixpkgs/9dcb002ca1690658be4a04645215baea8b95f31d";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; config.allowUnfree = true; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = import ./default.nix { inherit pkgs; };
        });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = import ./shell.nix { inherit pkgs; };
        });
    };
}
