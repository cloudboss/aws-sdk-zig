/// Indicates whether the instance is enabled for Amazon Web Services Nitro
/// Enclaves.
pub const AwsEc2LaunchTemplateDataEnclaveOptionsDetails = struct {
    /// If this parameter is set to `true`, the instance is enabled for Amazon Web
    /// Services Nitro Enclaves.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
