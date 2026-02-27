const Hash = @import("hash.zig").Hash;

/// The analysis template artifact metadata.
pub const AnalysisTemplateArtifactMetadata = struct {
    /// Additional artifact hashes for the analysis template.
    additional_artifact_hashes: ?[]const Hash,

    /// The hash of the entry point for the analysis template artifact metadata.
    entry_point_hash: Hash,

    pub const json_field_names = .{
        .additional_artifact_hashes = "additionalArtifactHashes",
        .entry_point_hash = "entryPointHash",
    };
};
