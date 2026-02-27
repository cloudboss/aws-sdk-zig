const ClientStat = @import("client_stat.zig").ClientStat;

/// The summary information about deprecated resource usage for an insight check
/// in the
/// `UPGRADE_READINESS` category.
pub const DeprecationDetail = struct {
    /// Details about Kubernetes clients using the deprecated resources.
    client_stats: ?[]const ClientStat,

    /// The newer version of the resource to migrate to if applicable.
    replaced_with: ?[]const u8,

    /// The version of the software where the newer resource version became
    /// available to
    /// migrate to if applicable.
    start_serving_replacement_version: ?[]const u8,

    /// The version of the software where the deprecated resource version will stop
    /// being
    /// served.
    stop_serving_version: ?[]const u8,

    /// The deprecated version of the resource.
    usage: ?[]const u8,

    pub const json_field_names = .{
        .client_stats = "clientStats",
        .replaced_with = "replacedWith",
        .start_serving_replacement_version = "startServingReplacementVersion",
        .stop_serving_version = "stopServingVersion",
        .usage = "usage",
    };
};
