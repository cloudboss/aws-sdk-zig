const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Describes a user in the user pool.
pub const User = struct {
    /// The ARN of the user.
    arn: ?[]const u8,

    /// The authentication type for the user.
    authentication_type: AuthenticationType,

    /// The date and time the user was created in the user pool.
    created_time: ?i64,

    /// Specifies whether the user in the user pool is enabled.
    enabled: ?bool,

    /// The first name, or given name, of the user.
    first_name: ?[]const u8,

    /// The last name, or surname, of the user.
    last_name: ?[]const u8,

    /// The status of the user in the user pool. The status can be one of the
    /// following:
    ///
    /// * UNCONFIRMED – The user is created but not confirmed.
    ///
    /// * CONFIRMED – The user is confirmed.
    ///
    /// * ARCHIVED – The user is no longer active.
    ///
    /// * COMPROMISED – The user is disabled because of a potential security threat.
    ///
    /// * UNKNOWN – The user status is not known.
    status: ?[]const u8,

    /// The email address of the user.
    ///
    /// Users' email addresses are case-sensitive.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .authentication_type = "AuthenticationType",
        .created_time = "CreatedTime",
        .enabled = "Enabled",
        .first_name = "FirstName",
        .last_name = "LastName",
        .status = "Status",
        .user_name = "UserName",
    };
};
