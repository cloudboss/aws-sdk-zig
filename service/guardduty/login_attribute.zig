/// Information about the login attempts.
pub const LoginAttribute = struct {
    /// Indicates the application name used to attempt log in.
    application: ?[]const u8,

    /// Represents the sum of failed (unsuccessful) login attempts made to establish
    /// a connection
    /// to the database instance.
    failed_login_attempts: ?i32,

    /// Represents the sum of successful connections (a correct combination of login
    /// attributes)
    /// made to the database instance by the actor.
    successful_login_attempts: ?i32,

    /// Indicates the user name which attempted to log in.
    user: ?[]const u8,

    pub const json_field_names = .{
        .application = "Application",
        .failed_login_attempts = "FailedLoginAttempts",
        .successful_login_attempts = "SuccessfulLoginAttempts",
        .user = "User",
    };
};
