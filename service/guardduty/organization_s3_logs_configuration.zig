/// Describes whether S3 data event logs will be automatically enabled for new
/// members of the organization.
pub const OrganizationS3LogsConfiguration = struct {
    /// A value that contains information on whether S3 data event logs will be
    /// enabled automatically as a data source for the organization.
    auto_enable: bool,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
