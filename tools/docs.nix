{
  writeShellScriptBin,
  rust,
  ...
}:
writeShellScriptBin "docs" ''
  set -xeuo pipefail

  ${rust}/bin/cargo doc --no-deps \
      -p forge-config \
      -p forge-error \
      -p forge-macro \
      -p forge-proto \
      -p forge-scheduler \
      -p forge-service \
      -p forge-store \
      -p forge-util \
      -p forge-worker \
      --open
''
