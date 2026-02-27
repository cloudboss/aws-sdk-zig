/// The Amazon Q properties of the connection.
pub const AmazonQPropertiesPatch = struct {
    /// The authentication mode of the connection's Amazon Q properties.
    auth_mode: ?[]const u8,

    /// Specifies whether Amazon Q is enabled for the connection.
    is_enabled: bool,

    /// The profile ARN of the connection's Amazon Q properties.
    profile_arn: ?[]const u8,

    pub const json_field_names = .{
        .auth_mode = "authMode",
        .is_enabled = "isEnabled",
        .profile_arn = "profileArn",
    };
};
