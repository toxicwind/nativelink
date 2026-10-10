{
  forge,
  buildstream,
  writeShellScriptBin,
}:
writeShellScriptBin "buildstream-with-forge-test" ''
  set -uo pipefail

  cleanup() {
    local pids=$(jobs -pr)
    [ -n "$pids" ] && kill $pids
  }
  trap "cleanup" INT QUIT TERM EXIT

  NL_LOG=json ${forge}/bin/forge -- integration_tests/buildstream/buildstream_cas.json5 | tee -i integration_tests/buildstream/forge.log &

  bst_output=$(cd integration_tests/buildstream && ${buildstream}/bin/bst -c buildstream.conf build hello.bst 2>&1 | tee -i buildstream.log)

  case $bst_output in
    *"SUCCESS Build"* )
      echo "Saw a successful buildstream build"
    ;;
    *)
      echo 'Failed buildstream build:'
      echo $bst_output
      exit 1
    ;;
  esac

  forge_output=$(cat integration_tests/buildstream/forge.log)

  case $forge_output in
    *\"ERROR\"* )
      echo "Error in forge build"
      exit 1
    ;;
    *)
      echo 'Successful forge build'
    ;;
  esac
''
