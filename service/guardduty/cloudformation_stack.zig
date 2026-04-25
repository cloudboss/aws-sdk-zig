/// Contains information about the CloudFormation stack involved in a GuardDuty
/// finding, including unique identifiers of the Amazon EC2 instances.
pub const CloudformationStack = struct {
    /// A list of unique identifiers for the compromised Amazon EC2 instances that
    /// were created as part of the same CloudFormation stack.
    ec_2_instance_uids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
    };
};
