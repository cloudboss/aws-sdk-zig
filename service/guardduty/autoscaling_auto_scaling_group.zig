/// Contains information about the Auto Scaling Group involved in a GuardDuty
/// finding,
/// including unique identifiers of the Amazon EC2 instances.
pub const AutoscalingAutoScalingGroup = struct {
    /// A list of unique identifiers for the compromised Amazon EC2 instances that
    /// are part of the
    /// same Auto Scaling Group.
    ec_2_instance_uids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
    };
};
