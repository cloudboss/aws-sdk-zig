/// The users that belong to a group.
pub const MemberUser = struct {
    /// The identifier of the user you want to map to a group.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
