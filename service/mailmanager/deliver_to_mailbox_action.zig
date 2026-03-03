const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// This action to delivers an email to a mailbox.
pub const DeliverToMailboxAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the mailbox ARN is no longer
    /// valid.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The Amazon Resource Name (ARN) of a WorkMail organization to deliver the
    /// email to.
    mailbox_arn: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role to use to execute this action.
    /// The role must have access to the workmail:DeliverToMailbox API.
    role_arn: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .mailbox_arn = "MailboxArn",
        .role_arn = "RoleArn",
    };
};
