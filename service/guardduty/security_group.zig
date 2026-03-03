/// Contains information about the security groups associated with the EC2
/// instance.
pub const SecurityGroup = struct {
    /// The security group ID of the EC2 instance.
    group_id: ?[]const u8 = null,

    /// The security group name of the EC2 instance.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
    };
};
