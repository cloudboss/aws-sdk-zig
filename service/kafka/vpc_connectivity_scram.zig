/// Details for SASL/SCRAM client authentication for VPC connectivity.
pub const VpcConnectivityScram = struct {
    /// SASL/SCRAM authentication is on or off for VPC connectivity.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
