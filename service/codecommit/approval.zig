const ApprovalState = @import("approval_state.zig").ApprovalState;

/// Returns information about a specific approval on a pull request.
pub const Approval = struct {
    /// The state of the approval, APPROVE or REVOKE. REVOKE states are not stored.
    approval_state: ?ApprovalState = null,

    /// The Amazon Resource Name (ARN) of the user.
    user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_state = "approvalState",
        .user_arn = "userArn",
    };
};
