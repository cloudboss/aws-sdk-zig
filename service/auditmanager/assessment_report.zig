const AssessmentReportStatus = @import("assessment_report_status.zig").AssessmentReportStatus;

/// A finalized document that's generated from an Audit Manager assessment.
/// These
/// reports summarize the relevant evidence that was collected for your audit,
/// and link to the
/// relevant evidence folders. These evidence folders are named and organized
/// according to the
/// controls that are specified in your assessment.
pub const AssessmentReport = struct {
    /// The identifier for the specified assessment.
    assessment_id: ?[]const u8,

    /// The name of the associated assessment.
    assessment_name: ?[]const u8,

    /// The name of the user who created the assessment report.
    author: ?[]const u8,

    /// The identifier for the specified Amazon Web Services account.
    aws_account_id: ?[]const u8,

    /// Specifies when the assessment report was created.
    creation_time: ?i64,

    /// The description of the specified assessment report.
    description: ?[]const u8,

    /// The unique identifier for the assessment report.
    id: ?[]const u8,

    /// The name that's given to the assessment report.
    name: ?[]const u8,

    /// The current status of the specified assessment report.
    status: ?AssessmentReportStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .author = "author",
        .aws_account_id = "awsAccountId",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
