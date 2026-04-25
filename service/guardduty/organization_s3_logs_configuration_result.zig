/// The current configuration of S3 data event logs as a data source for the
/// organization.
pub const OrganizationS3LogsConfigurationResult = struct {
    /// A value that describes whether S3 data event logs are automatically enabled
    /// for new members of the organization.
    auto_enable: bool,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
