/// The POSIX user.
pub const PosixUser = struct {
    /// The name of the POSIX user's group.
    group: []const u8,

    /// The name of the POSIX user.
    user: []const u8,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};
