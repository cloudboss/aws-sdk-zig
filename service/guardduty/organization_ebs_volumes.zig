/// Organization-wide EBS volumes scan configuration.
pub const OrganizationEbsVolumes = struct {
    /// Whether scanning EBS volumes should be auto-enabled for new members joining
    /// the
    /// organization.
    auto_enable: ?bool = null,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
