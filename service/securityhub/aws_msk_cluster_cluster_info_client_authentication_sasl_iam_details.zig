/// Details for SASL/IAM client authentication.
pub const AwsMskClusterClusterInfoClientAuthenticationSaslIamDetails = struct {
    /// Indicates whether SASL/IAM authentication is enabled or not.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
