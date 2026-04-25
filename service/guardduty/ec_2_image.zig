/// Contains information about the Amazon EC2 Image involved in a GuardDuty
/// finding, including unique identifiers of the Amazon EC2 instances.
pub const Ec2Image = struct {
    /// A list of unique identifiers for the compromised Amazon EC2 instances that
    /// were launched with the same Amazon Machine Image (AMI).
    ec_2_instance_uids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
    };
};
