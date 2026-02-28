const InputAuthenticationType = @import("input_authentication_type.zig").InputAuthenticationType;

/// Specifies the authentication mode to use.
pub const AuthenticationMode = struct {
    /// Specifies the passwords to use for authentication if `Type` is set to
    /// `password`.
    passwords: ?[]const []const u8,

    /// Specifies the authentication type. Possible options are IAM authentication,
    /// password
    /// and no password.
    @"type": ?InputAuthenticationType,
};
