{
  forge,
  writeShellScriptBin,
}:
writeShellScriptBin "is-executable-test" ''
  set -uo pipefail

  forge_output="$(${forge}/bin/forge 2>&1)"

  print_error_output=$(cat <<EOF
  error: the following required arguments were not provided:
    <CONFIG_FILE>

  Usage: forge <CONFIG_FILE>

  For more information, try '--help'.
  EOF
  )

  if [ "$forge_output" = "$print_error_output" ]; then
    echo "The output of forge matches the print_error output."
  else
    echo 'The output of forge does not match the print_error output:'
    diff <(echo "$forge_output") <(echo "$print_error_output") >&2
    exit 1
  fi
''
