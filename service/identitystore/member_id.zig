/// An object containing the identifier of a group member.
pub const MemberId = union(enum) {
    /// An object containing the identifiers of resources that can be members.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
