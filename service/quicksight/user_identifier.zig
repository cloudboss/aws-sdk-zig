/// A structure that contains information to identify a user.
pub const UserIdentifier = union(enum) {
    /// The email address of the user that you want to get identity context for.
    email: ?[]const u8,
    /// The Amazon Resource Name (ARN) of the user that you want to get identity
    /// context for.
    user_arn: ?[]const u8,
    /// The name of the user that you want to get identity context for.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .email = "Email",
        .user_arn = "UserArn",
        .user_name = "UserName",
    };
};
