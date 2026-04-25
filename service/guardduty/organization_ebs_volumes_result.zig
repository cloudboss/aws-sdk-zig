/// An object that contains information on the status of whether EBS volumes
/// scanning will be enabled as a data source for an organization.
pub const OrganizationEbsVolumesResult = struct {
    /// An object that contains the status of whether scanning EBS volumes should be
    /// auto-enabled for new members joining the organization.
    auto_enable: ?bool = null,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
