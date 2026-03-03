const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Describes a user in the user pool and the associated stack.
pub const UserStackAssociation = struct {
    /// The authentication type for the user.
    authentication_type: AuthenticationType,

    /// Specifies whether a welcome email is sent to a user after the user is
    /// created in the user pool.
    send_email_notification: ?bool = null,

    /// The name of the stack that is associated with the user.
    stack_name: []const u8,

    /// The email address of the user who is associated with the stack.
    ///
    /// Users' email addresses are case-sensitive.
    user_name: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .send_email_notification = "SendEmailNotification",
        .stack_name = "StackName",
        .user_name = "UserName",
    };
};
