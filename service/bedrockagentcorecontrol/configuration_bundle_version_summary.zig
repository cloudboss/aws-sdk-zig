const VersionLineageMetadata = @import("version_lineage_metadata.zig").VersionLineageMetadata;

/// Summary information about a configuration bundle version.
pub const ConfigurationBundleVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The unique identifier of the configuration bundle.
    bundle_id: []const u8,

    /// The version lineage metadata, including parent versions, branch name, and
    /// creation source.
    lineage_metadata: ?VersionLineageMetadata = null,

    /// The timestamp when this version was created.
    version_created_at: i64,

    /// The version identifier of this configuration bundle version.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_id = "bundleId",
        .lineage_metadata = "lineageMetadata",
        .version_created_at = "versionCreatedAt",
        .version_id = "versionId",
    };
};
