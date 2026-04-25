const EbsVolumesResult = @import("ebs_volumes_result.zig").EbsVolumesResult;

/// An object that contains information on the status of whether Malware
/// Protection for EC2 instances with findings will be enabled as a data source.
pub const ScanEc2InstanceWithFindingsResult = struct {
    /// Describes the configuration of scanning EBS volumes as a data source.
    ebs_volumes: ?EbsVolumesResult = null,

    pub const json_field_names = .{
        .ebs_volumes = "EbsVolumes",
    };
};
