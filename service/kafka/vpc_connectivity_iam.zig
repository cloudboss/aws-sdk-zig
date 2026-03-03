/// Details for IAM access control for VPC connectivity.
pub const VpcConnectivityIam = struct {
    /// SASL/IAM authentication is on or off for VPC connectivity.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
