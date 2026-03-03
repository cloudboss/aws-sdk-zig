/// Compatibility information.
pub const Compatibility = struct {
    /// The supported Kubernetes version of the cluster.
    cluster_version: ?[]const u8 = null,

    /// The supported default version.
    default_version: bool = false,

    /// The supported compute platform.
    platform_versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_version = "clusterVersion",
        .default_version = "defaultVersion",
        .platform_versions = "platformVersions",
    };
};
