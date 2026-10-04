/// A filter that matches users by username or email prefix.
pub const UserNameOrEmailFilter = struct {
    /// The prefix to match against username or email (starts-with match).
    prefix: []const u8,

    pub const json_field_names = .{
        .prefix = "prefix",
    };
};
