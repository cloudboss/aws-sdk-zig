const CheckProvider = @import("check_provider.zig").CheckProvider;
const CheckFailureReason = @import("check_failure_reason.zig").CheckFailureReason;
const CheckStatus = @import("check_status.zig").CheckStatus;

/// Account details for a Well-Architected best practice in relation to Trusted
/// Advisor checks.
pub const CheckDetail = struct {
    account_id: ?[]const u8,

    choice_id: ?[]const u8,

    /// Trusted Advisor check description.
    description: ?[]const u8,

    /// Count of flagged resources associated to the check.
    flagged_resources: ?i32,

    /// Trusted Advisor check ID.
    id: ?[]const u8,

    /// Well-Architected Lens ARN associated to the check.
    lens_arn: ?[]const u8,

    /// Trusted Advisor check name.
    name: ?[]const u8,

    pillar_id: ?[]const u8,

    /// Provider of the check related to the best practice.
    provider: ?CheckProvider,

    question_id: ?[]const u8,

    /// Reason associated to the check.
    reason: ?CheckFailureReason,

    /// Status associated to the check.
    status: ?CheckStatus,

    updated_at: ?i64,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .choice_id = "ChoiceId",
        .description = "Description",
        .flagged_resources = "FlaggedResources",
        .id = "Id",
        .lens_arn = "LensArn",
        .name = "Name",
        .pillar_id = "PillarId",
        .provider = "Provider",
        .question_id = "QuestionId",
        .reason = "Reason",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
