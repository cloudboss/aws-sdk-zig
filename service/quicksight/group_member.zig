/// A member of an Quick Sight group. Currently, group members must be users.
/// Groups
/// can't be members of another group. .
pub const GroupMember = struct {
    /// The Amazon Resource Name (ARN) for the group member (user).
    arn: ?[]const u8 = null,

    /// The name of the group member (user).
    member_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .member_name = "MemberName",
    };
};
