const VpcConnectivitySasl = @import("vpc_connectivity_sasl.zig").VpcConnectivitySasl;
const VpcConnectivityTls = @import("vpc_connectivity_tls.zig").VpcConnectivityTls;

/// Includes all client authentication information for VPC connectivity.
pub const VpcConnectivityClientAuthentication = struct {
    /// SASL authentication type details for VPC connectivity.
    sasl: ?VpcConnectivitySasl = null,

    /// TLS authentication type details for VPC connectivity.
    tls: ?VpcConnectivityTls = null,

    pub const json_field_names = .{
        .sasl = "Sasl",
        .tls = "Tls",
    };
};
