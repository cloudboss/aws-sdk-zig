const ApprovalStrategyResponse = @import("approval_strategy_response.zig").ApprovalStrategyResponse;
const GetApprovalTeamResponseApprover = @import("get_approval_team_response_approver.zig").GetApprovalTeamResponseApprover;
const ApprovalTeamStatus = @import("approval_team_status.zig").ApprovalTeamStatus;
const ApprovalTeamStatusCode = @import("approval_team_status_code.zig").ApprovalTeamStatusCode;

/// Contains details for the pending updates for an approval team, if
/// applicable.
pub const PendingUpdate = struct {
    /// An `ApprovalStrategyResponse` object. Contains details for how the team
    /// grants approval.
    approval_strategy: ?ApprovalStrategyResponse,

    /// An array of `GetApprovalTeamResponseApprover ` objects. Contains details for
    /// the approvers in the team.
    approvers: ?[]const GetApprovalTeamResponseApprover,

    /// Description for the team.
    description: ?[]const u8,

    /// Total number of approvers in the team.
    number_of_approvers: ?i32,

    /// Status for the team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status: ?ApprovalTeamStatus,

    /// Status code for the update. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status_code: ?ApprovalTeamStatusCode,

    /// Message describing the status for the team.
    status_message: ?[]const u8,

    /// Timestamp when the update request was initiated.
    update_initiation_time: ?i64,

    /// Version ID for the team.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .approval_strategy = "ApprovalStrategy",
        .approvers = "Approvers",
        .description = "Description",
        .number_of_approvers = "NumberOfApprovers",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
        .update_initiation_time = "UpdateInitiationTime",
        .version_id = "VersionId",
    };
};
