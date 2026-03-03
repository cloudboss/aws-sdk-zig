const ApprovalStrategyResponse = @import("approval_strategy_response.zig").ApprovalStrategyResponse;
const ApprovalTeamStatus = @import("approval_team_status.zig").ApprovalTeamStatus;
const ApprovalTeamStatusCode = @import("approval_team_status_code.zig").ApprovalTeamStatusCode;

/// Contains details for an approval team
pub const ListApprovalTeamsResponseApprovalTeam = struct {
    /// An `ApprovalStrategyResponse` object. Contains details for how an approval
    /// team grants approval.
    approval_strategy: ?ApprovalStrategyResponse = null,

    /// Amazon Resource Name (ARN) for the team.
    arn: ?[]const u8 = null,

    /// Timestamp when the team was created.
    creation_time: ?i64 = null,

    /// Description for the team.
    description: ?[]const u8 = null,

    /// Name of the team.
    name: ?[]const u8 = null,

    /// Total number of approvers in the team.
    number_of_approvers: ?i32 = null,

    /// Status for the team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status: ?ApprovalTeamStatus = null,

    /// Status code for the team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    status_code: ?ApprovalTeamStatusCode = null,

    /// Message describing the status for the team.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_strategy = "ApprovalStrategy",
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .name = "Name",
        .number_of_approvers = "NumberOfApprovers",
        .status = "Status",
        .status_code = "StatusCode",
        .status_message = "StatusMessage",
    };
};
