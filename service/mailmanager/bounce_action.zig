const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// The action to send a bounce response for the email. When executed, this
/// action generates a non-delivery report (bounce) back to the sender.
pub const BounceAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the caller does not have the
    /// permissions to call the SendBounce API.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The diagnostic message included in the Diagnostic-Code header of the bounce.
    diagnostic_message: []const u8,

    /// The human-readable text to include in the bounce message.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to use to send the bounce
    /// message.
    role_arn: []const u8,

    /// The sender email address of the bounce message.
    sender: []const u8,

    /// The SMTP reply code for the bounce, as defined by RFC 5321.
    smtp_reply_code: []const u8,

    /// The enhanced status code for the bounce, in the format of x.y.z (e.g.
    /// 5.1.1).
    status_code: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .diagnostic_message = "DiagnosticMessage",
        .message = "Message",
        .role_arn = "RoleArn",
        .sender = "Sender",
        .smtp_reply_code = "SmtpReplyCode",
        .status_code = "StatusCode",
    };
};
