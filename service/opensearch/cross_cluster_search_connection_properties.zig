const SkipUnavailableStatus = @import("skip_unavailable_status.zig").SkipUnavailableStatus;

/// Cross-cluster search specific connection properties.
pub const CrossClusterSearchConnectionProperties = struct {
    /// The status of the `SkipUnavailable` setting for the outbound connection.
    /// This feature allows you to specify some clusters as optional and ensure that
    /// your
    /// cross-cluster queries return partial results despite failures on one or more
    /// remote
    /// clusters.
    skip_unavailable: ?SkipUnavailableStatus,

    pub const json_field_names = .{
        .skip_unavailable = "SkipUnavailable",
    };
};
