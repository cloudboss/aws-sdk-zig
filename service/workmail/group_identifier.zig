/// The identifier that contains the Group ID and name of a group.
pub const GroupIdentifier = struct {
    /// Group ID that matched the group.
    group_id: ?[]const u8 = null,

    /// Group name that matched the group.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
    };
};
