const OrganizationEbsVolumesResult = @import("organization_ebs_volumes_result.zig").OrganizationEbsVolumesResult;

/// An object that contains information on the status of scanning EC2 instances
/// with findings for an organization.
pub const OrganizationScanEc2InstanceWithFindingsResult = struct {
    /// Describes the configuration for scanning EBS volumes for an organization.
    ebs_volumes: ?OrganizationEbsVolumesResult = null,

    pub const json_field_names = .{
        .ebs_volumes = "EbsVolumes",
    };
};
