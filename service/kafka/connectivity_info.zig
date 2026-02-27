const PublicAccess = @import("public_access.zig").PublicAccess;
const VpcConnectivity = @import("vpc_connectivity.zig").VpcConnectivity;

/// Information about the broker access configuration.
pub const ConnectivityInfo = struct {
    /// Public access control for brokers.
    public_access: ?PublicAccess,

    /// VPC connectivity access control for brokers.
    vpc_connectivity: ?VpcConnectivity,

    pub const json_field_names = .{
        .public_access = "PublicAccess",
        .vpc_connectivity = "VpcConnectivity",
    };
};
