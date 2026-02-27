/// The Windows user details.
pub const WindowsUser = struct {
    /// The password ARN for the Windows user.
    password_arn: []const u8,

    /// The user.
    user: []const u8,

    pub const json_field_names = .{
        .password_arn = "passwordArn",
        .user = "user",
    };
};
