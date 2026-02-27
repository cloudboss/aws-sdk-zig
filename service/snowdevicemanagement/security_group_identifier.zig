/// Information about the device's security group.
pub const SecurityGroupIdentifier = struct {
    /// The security group ID.
    group_id: ?[]const u8,

    /// The security group name.
    group_name: ?[]const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .group_name = "groupName",
    };
};
