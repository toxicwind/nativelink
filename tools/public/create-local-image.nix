{writeShellScriptBin}:
writeShellScriptBin "create-local-image" ''
  set -euo pipefail

  nix run .#image.copyTo docker-daemon:local-forge:latest
  echo "Created local-forge image"
''
