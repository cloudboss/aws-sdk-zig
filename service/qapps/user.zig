/// A user of an Amazon Q App.
pub const User = struct {
    /// The unique identifier of a user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
