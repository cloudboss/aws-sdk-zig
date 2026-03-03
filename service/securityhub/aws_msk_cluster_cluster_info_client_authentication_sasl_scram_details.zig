/// Details for SASL/SCRAM client authentication.
pub const AwsMskClusterClusterInfoClientAuthenticationSaslScramDetails = struct {
    /// Indicates whether SASL/SCRAM authentication is enabled or not.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
