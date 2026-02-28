const InputAuthenticationType = @import("input_authentication_type.zig").InputAuthenticationType;

/// Denotes the user's authentication properties, such as whether it requires a
/// password to authenticate. Used in output responses.
pub const AuthenticationMode = struct {
    /// The password(s) used for authentication
    passwords: ?[]const []const u8,

    /// Indicates whether the user requires a password to authenticate. All
    /// newly-created users require a password.
    @"type": ?InputAuthenticationType,

    pub const json_field_names = .{
        .passwords = "Passwords",
        .@"type" = "Type",
    };
};
