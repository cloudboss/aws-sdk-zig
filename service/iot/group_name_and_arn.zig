/// The name and ARN of a group.
pub const GroupNameAndArn = struct {
    /// The group ARN.
    group_arn: ?[]const u8,

    /// The group name.
    group_name: ?[]const u8,

    pub const json_field_names = .{
        .group_arn = "groupArn",
        .group_name = "groupName",
    };
};
