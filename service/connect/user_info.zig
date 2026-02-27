/// The user details for the contact.
pub const UserInfo = struct {
    /// The user identifier for the contact.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
