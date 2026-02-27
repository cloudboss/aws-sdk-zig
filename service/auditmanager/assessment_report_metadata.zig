const AssessmentReportStatus = @import("assessment_report_status.zig").AssessmentReportStatus;

/// The metadata objects that are associated with the specified assessment
/// report.
pub const AssessmentReportMetadata = struct {
    /// The unique identifier for the associated assessment.
    assessment_id: ?[]const u8,

    /// The name of the associated assessment.
    assessment_name: ?[]const u8,

    /// The name of the user who created the assessment report.
    author: ?[]const u8,

    /// Specifies when the assessment report was created.
    creation_time: ?i64,

    /// The description of the assessment report.
    description: ?[]const u8,

    /// The unique identifier for the assessment report.
    id: ?[]const u8,

    /// The name of the assessment report.
    name: ?[]const u8,

    /// The current status of the assessment report.
    status: ?AssessmentReportStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .author = "author",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
