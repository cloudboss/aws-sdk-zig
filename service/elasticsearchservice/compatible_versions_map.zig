/// A map from an
/// `
/// ElasticsearchVersion
/// `
/// to a list of compatible
/// `
/// ElasticsearchVersion
/// `
/// s to which the domain can be upgraded.
pub const CompatibleVersionsMap = struct {
    /// The current version of Elasticsearch on which a domain is.
    source_version: ?[]const u8 = null,

    target_versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .source_version = "SourceVersion",
        .target_versions = "TargetVersions",
    };
};
