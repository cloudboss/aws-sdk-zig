const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// Sends the email to the internet using the ses:SendRawEmail API.
pub const SendAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the caller does not have the
    /// permissions to call the sendRawEmail API.
    action_failure_policy: ?ActionFailurePolicy,

    /// The Amazon Resource Name (ARN) of the role to use for this action. This role
    /// must have access to the ses:SendRawEmail API.
    role_arn: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .role_arn = "RoleArn",
    };
};
