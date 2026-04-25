/// Describes whether Malware Protection for EC2 instances with findings will be
/// enabled as a data source.
pub const ScanEc2InstanceWithFindings = struct {
    /// Describes the configuration for scanning EBS volumes as data source.
    ebs_volumes: ?bool = null,

    pub const json_field_names = .{
        .ebs_volumes = "EbsVolumes",
    };
};
