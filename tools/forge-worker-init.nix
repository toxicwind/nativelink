{
  buildImage,
  self,
  lib,
  archPackages,
  forge-image,
  arch,
}:
# This image copies a bundled `forge` executable to a specified location.
#
# Toolchain containers shouldn't have the `forge` executable built-in since
# it would make it hard to update toolchain dependencies and forge
# independently.
#
# Instead, use this image as initContainer to populate a shared volume in a
# Deployment. Then mount that volume into the toolchain container and set the
# Deployment's entrypoint to the mounted `forge` executable.
let
  copyToDestination = archPackages.writeShellScriptBin "copyToDestination" ''
    cp -Lv /bin/forge "$@"
  '';
in
  buildImage {
    name = "forge-worker-init";
    # Workers should use the same version of Forge as the scheduler and cas
    # deployments. Use the same tag for the init image so that users don't need to
    # manage multiple tags.
    fromImage = forge-image;
    tag = forge-image.imageTag;
    copyToRoot = [archPackages.coreutils];
    inherit arch;
    config = {
      Entrypoint = [(lib.getExe' copyToDestination "copyToDestination")];
      Labels = {
        "org.opencontainers.image.description" = "Init container to prepare Forge workers.";
        "org.opencontainers.image.documentation" = "https://github.com/toxicwind/forge";
        "org.opencontainers.image.licenses" = "FSL-1.1-Apache-2.0";
        "org.opencontainers.image.revision" = "${self.rev or self.dirtyRev or "dirty"}";
        "org.opencontainers.image.source" = "https://github.com/toxicwind/forge";
        "org.opencontainers.image.title" = "Forge worker init";
        "org.opencontainers.image.vendor" = "Trace Machina, Inc.";
      };
    };
  }
