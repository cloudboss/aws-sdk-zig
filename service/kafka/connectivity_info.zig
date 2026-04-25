const NetworkType = @import("network_type.zig").NetworkType;
const PublicAccess = @import("public_access.zig").PublicAccess;
const VpcConnectivity = @import("vpc_connectivity.zig").VpcConnectivity;

/// Information about the broker access configuration.
pub const ConnectivityInfo = struct {
    /// The network type of the cluster, which is IPv4 or DUAL. The DUAL network
    /// type uses both IPv4 and IPv6 addresses for your cluster and its resources.
    ///
    /// By default, a cluster uses the IPv4 network type.
    network_type: ?NetworkType = null,

    /// Public access control for brokers.
    public_access: ?PublicAccess = null,

    /// VPC connectivity access control for brokers.
    vpc_connectivity: ?VpcConnectivity = null,

    pub const json_field_names = .{
        .network_type = "NetworkType",
        .public_access = "PublicAccess",
        .vpc_connectivity = "VpcConnectivity",
    };
};
