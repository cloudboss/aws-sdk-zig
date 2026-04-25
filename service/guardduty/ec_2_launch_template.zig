/// Contains information about the Amazon EC2 launch template involved in a
/// GuardDuty finding, including unique identifiers of the Amazon EC2 instances.
pub const Ec2LaunchTemplate = struct {
    /// A list of unique identifiers for the compromised Amazon EC2 instances that
    /// share the same Amazon EC2 launch template.
    ec_2_instance_uids: ?[]const []const u8 = null,

    /// Version of the EC2 launch template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
        .version = "Version",
    };
};
