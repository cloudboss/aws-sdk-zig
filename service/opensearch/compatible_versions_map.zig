/// A map of OpenSearch or Elasticsearch versions and the versions you can
/// upgrade them
/// to.
pub const CompatibleVersionsMap = struct {
    /// The current version that the OpenSearch Service domain is running.
    source_version: ?[]const u8,

    /// The possible versions that you can upgrade the domain to.
    target_versions: ?[]const []const u8,

    pub const json_field_names = .{
        .source_version = "SourceVersion",
        .target_versions = "TargetVersions",
    };
};
