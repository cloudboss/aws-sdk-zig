const NetworkType = @import("network_type.zig").NetworkType;

/// Describes the cluster's connectivity information, such as its network type,
/// which is IPv4 or DUAL.
pub const ServerlessConnectivityInfo = struct {
    /// The network type of the cluster, which is IPv4 or DUAL. The DUAL network
    /// type uses both IPv4 and IPv6 addresses for your cluster and its resources.
    ///
    /// By default, a cluster uses the IPv4 network type.
    network_type: ?NetworkType = null,

    pub const json_field_names = .{
        .network_type = "NetworkType",
    };
};
