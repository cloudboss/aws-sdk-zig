const LogSetup = @import("log_setup.zig").LogSetup;

/// An object representing the logging configuration for resources in your
/// cluster.
pub const Logging = struct {
    /// The cluster control plane logging configuration for your cluster.
    cluster_logging: ?[]const LogSetup,

    pub const json_field_names = .{
        .cluster_logging = "clusterLogging",
    };
};
