/// A *group* in Quick Sight consists of a set of users. You can
/// use groups to make it easier to manage access and security.
pub const Group = struct {
    /// The Amazon Resource Name (ARN) for the group.
    arn: ?[]const u8,

    /// The group description.
    description: ?[]const u8,

    /// The name of the group.
    group_name: ?[]const u8,

    /// The principal ID of the group.
    principal_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .group_name = "GroupName",
        .principal_id = "PrincipalId",
    };
};
