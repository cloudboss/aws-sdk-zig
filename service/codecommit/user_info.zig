/// Information about the user who made a specified commit.
pub const UserInfo = struct {
    /// The date when the specified commit was commited, in timestamp format with
    /// GMT offset.
    date: ?[]const u8 = null,

    /// The email address associated with the user who made the commit, if any.
    email: ?[]const u8 = null,

    /// The name of the user who made the specified commit.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .date = "date",
        .email = "email",
        .name = "name",
    };
};
