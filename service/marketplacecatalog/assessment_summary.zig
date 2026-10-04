const AssessmentResult = @import("assessment_result.zig").AssessmentResult;
const AssessmentTargetSummary = @import("assessment_target_summary.zig").AssessmentTargetSummary;
const FrameworkSummary = @import("framework_summary.zig").FrameworkSummary;

/// Summarized information about an assessment.
pub const AssessmentSummary = struct {
    /// The ARN associated with the assessment.
    assessment_arn: ?[]const u8 = null,

    /// The unique ID of the assessment.
    assessment_id: ?[]const u8 = null,

    /// The overall result of the assessment.
    assessment_result: ?AssessmentResult = null,

    /// Identifies the entity or change set that was assessed.
    assessment_target_summary: ?AssessmentTargetSummary = null,

    /// The date and time the assessment was created, in ISO 8601 format
    /// (`2018-02-27T13:45:22Z`).
    created_at: ?[]const u8 = null,

    /// The date and time the assessment expires, in ISO 8601 format
    /// (`2018-02-27T13:45:22Z`).
    expires_at: ?[]const u8 = null,

    /// The identifier of the framework that was evaluated by this assessment, in
    /// the format
    /// `frameworkId@version` (for example,
    /// `AMISecurity@1.0`).
    framework_id: ?[]const u8 = null,

    /// The framework-specific details of the assessed resource. The set member
    /// corresponds
    /// to the framework identified by `FrameworkId`.
    framework_summary: ?FrameworkSummary = null,

    pub const json_field_names = .{
        .assessment_arn = "AssessmentArn",
        .assessment_id = "AssessmentId",
        .assessment_result = "AssessmentResult",
        .assessment_target_summary = "AssessmentTargetSummary",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .framework_id = "FrameworkId",
        .framework_summary = "FrameworkSummary",
    };
};
