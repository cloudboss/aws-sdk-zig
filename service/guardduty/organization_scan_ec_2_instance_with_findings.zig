const OrganizationEbsVolumes = @import("organization_ebs_volumes.zig").OrganizationEbsVolumes;

/// Organization-wide EC2 instances with findings scan configuration.
pub const OrganizationScanEc2InstanceWithFindings = struct {
    /// Whether scanning EBS volumes should be auto-enabled for new members joining
    /// the organization.
    ebs_volumes: ?OrganizationEbsVolumes = null,

    pub const json_field_names = .{
        .ebs_volumes = "EbsVolumes",
    };
};
