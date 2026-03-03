/// A security group associated with the network interface.
pub const AwsEc2NetworkInterfaceSecurityGroup = struct {
    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The name of the security group.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
    };
};
