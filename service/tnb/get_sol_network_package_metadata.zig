const NetworkArtifactMeta = @import("network_artifact_meta.zig").NetworkArtifactMeta;

/// Metadata associated with a network package.
///
/// A network package is a .zip file in CSAR (Cloud Service Archive) format
/// defines the function packages you want to deploy and the Amazon Web Services
/// infrastructure you want to deploy them on.
pub const GetSolNetworkPackageMetadata = struct {
    /// The date that the resource was created.
    created_at: i64,

    /// The date that the resource was last modified.
    last_modified: i64,

    /// Metadata related to the onboarded network service descriptor in the network
    /// package.
    nsd: ?NetworkArtifactMeta,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .last_modified = "lastModified",
        .nsd = "nsd",
    };
};
