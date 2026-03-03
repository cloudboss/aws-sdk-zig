const NetworkArtifactMeta = @import("network_artifact_meta.zig").NetworkArtifactMeta;

/// Update metadata in a network package.
///
/// A network package is a .zip file in CSAR (Cloud Service Archive) format
/// defines the function packages you want to deploy and the Amazon Web Services
/// infrastructure you want to deploy them on.
pub const PutSolNetworkPackageContentMetadata = struct {
    nsd: ?NetworkArtifactMeta = null,

    pub const json_field_names = .{
        .nsd = "nsd",
    };
};
