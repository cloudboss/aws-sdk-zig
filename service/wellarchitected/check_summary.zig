const aws = @import("aws");

const CheckProvider = @import("check_provider.zig").CheckProvider;
const CheckStatus = @import("check_status.zig").CheckStatus;

/// Trusted Advisor check summary.
pub const CheckSummary = struct {
    /// Account summary associated to the check.
    account_summary: ?[]const aws.map.MapEntry(i32),

    choice_id: ?[]const u8,

    /// Trusted Advisor check description.
    description: ?[]const u8,

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

    /// Status associated to the check.
    status: ?CheckStatus,

    updated_at: ?i64,

    pub const json_field_names = .{
        .account_summary = "AccountSummary",
        .choice_id = "ChoiceId",
        .description = "Description",
        .id = "Id",
        .lens_arn = "LensArn",
        .name = "Name",
        .pillar_id = "PillarId",
        .provider = "Provider",
        .question_id = "QuestionId",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
