/// Contains information about a security group associated with a network
/// interface. This
/// data type is used as one of the elements of the NetworkInterface data
/// type.
pub const SecurityGroup = struct {
    /// The ID of the security group.
    group_id: ?[]const u8,

    /// The name of the security group.
    group_name: ?[]const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .group_name = "groupName",
    };
};
