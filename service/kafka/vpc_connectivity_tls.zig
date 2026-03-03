/// Details for TLS client authentication for VPC connectivity.
pub const VpcConnectivityTls = struct {
    /// TLS authentication is on or off for VPC connectivity.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
