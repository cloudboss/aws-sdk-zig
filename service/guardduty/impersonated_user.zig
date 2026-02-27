/// Contains information about the impersonated user.
pub const ImpersonatedUser = struct {
    /// The `group` to which the user name belongs.
    groups: ?[]const []const u8,

    /// Information about the `username` that was being impersonated.
    username: ?[]const u8,

    pub const json_field_names = .{
        .groups = "Groups",
        .username = "Username",
    };
};
