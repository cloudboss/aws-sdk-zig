const PullRequestBuildApproverRole = @import("pull_request_build_approver_role.zig").PullRequestBuildApproverRole;
const PullRequestBuildCommentApproval = @import("pull_request_build_comment_approval.zig").PullRequestBuildCommentApproval;

/// A PullRequestBuildPolicy object that defines comment-based approval
/// requirements for triggering builds on pull requests. This policy helps
/// control when automated builds are executed based on contributor permissions
/// and approval workflows.
pub const PullRequestBuildPolicy = struct {
    /// List of repository roles that have approval privileges for pull request
    /// builds when comment approval is required. Only users with these roles can
    /// provide valid comment approvals. If a pull request contributor is one of
    /// these roles, their pull request builds will trigger automatically. This
    /// field is only applicable when `requiresCommentApproval` is not *DISABLED*.
    approver_roles: ?[]const PullRequestBuildApproverRole = null,

    /// Specifies when comment-based approval is required before triggering a build
    /// on pull requests. This setting determines whether builds run automatically
    /// or require explicit approval through comments.
    ///
    /// * *DISABLED*: Builds trigger automatically without requiring comment
    ///   approval
    ///
    /// * *ALL_PULL_REQUESTS*: All pull requests require comment approval before
    ///   builds execute (unless contributor is one of the approver roles)
    ///
    /// * *FORK_PULL_REQUESTS*: Only pull requests from forked repositories require
    ///   comment approval (unless contributor is one of the approver roles)
    requires_comment_approval: PullRequestBuildCommentApproval,

    pub const json_field_names = .{
        .approver_roles = "approverRoles",
        .requires_comment_approval = "requiresCommentApproval",
    };
};
