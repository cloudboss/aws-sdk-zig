const VpcConnectivityClientAuthentication = @import("vpc_connectivity_client_authentication.zig").VpcConnectivityClientAuthentication;

/// VPC connectivity access control for brokers.
pub const VpcConnectivity = struct {
    /// Includes all client authentication information for VPC connectivity.
    client_authentication: ?VpcConnectivityClientAuthentication = null,

    pub const json_field_names = .{
        .client_authentication = "ClientAuthentication",
    };
};
