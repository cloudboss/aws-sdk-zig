/// Provides information to verify the integrity of stored model artifacts.
pub const ModelDigests = struct {
    /// Provides a hash value that uniquely identifies the stored model artifacts.
    artifact_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_digest = "ArtifactDigest",
    };
};
