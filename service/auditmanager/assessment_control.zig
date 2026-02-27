const ControlComment = @import("control_comment.zig").ControlComment;
const ControlResponse = @import("control_response.zig").ControlResponse;
const ControlStatus = @import("control_status.zig").ControlStatus;

/// The control entity that represents a standard control or a custom control in
/// an Audit Manager assessment.
pub const AssessmentControl = struct {
    /// The amount of evidence in the assessment report.
    assessment_report_evidence_count: i32 = 0,

    /// The list of comments that's attached to the control.
    comments: ?[]const ControlComment,

    /// The description of the control.
    description: ?[]const u8,

    /// The amount of evidence that's collected for the control.
    evidence_count: i32 = 0,

    /// The list of data sources for the evidence.
    evidence_sources: ?[]const []const u8,

    /// The identifier for the control.
    id: ?[]const u8,

    /// The name of the control.
    name: ?[]const u8,

    /// The response of the control.
    response: ?ControlResponse,

    /// The status of the control.
    status: ?ControlStatus,

    pub const json_field_names = .{
        .assessment_report_evidence_count = "assessmentReportEvidenceCount",
        .comments = "comments",
        .description = "description",
        .evidence_count = "evidenceCount",
        .evidence_sources = "evidenceSources",
        .id = "id",
        .name = "name",
        .response = "response",
        .status = "status",
    };
};
