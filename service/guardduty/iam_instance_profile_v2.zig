/// Contains information about the IAM instance profile involved in a GuardDuty
/// finding, including unique identifiers of the Amazon EC2 instances.
pub const IamInstanceProfileV2 = struct {
    /// A list of unique identifiers for the compromised Amazon EC2 instances that
    /// share the same IAM instance profile.
    ec_2_instance_uids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
    };
};
