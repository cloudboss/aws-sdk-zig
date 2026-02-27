const ClusterConfig = @import("cluster_config.zig").ClusterConfig;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The cluster configuration status for a domain.
pub const ClusterConfigStatus = struct {
    /// Cluster configuration options for the specified domain.
    options: ClusterConfig,

    /// The status of cluster configuration options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
