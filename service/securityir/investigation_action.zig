const ActionType = @import("action_type.zig").ActionType;
const InvestigationFeedback = @import("investigation_feedback.zig").InvestigationFeedback;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Represents an investigation action performed within a case. This structure
/// captures the details of an automated or manual investigation, including its
/// status, results, and user feedback.
pub const InvestigationAction = struct {
    /// The type of investigation action being performed. This categorizes the
    /// investigation method or approach used in the case.
    action_type: ActionType,

    /// Detailed investigation results in rich markdown format. This field contains
    /// the comprehensive findings, analysis, and conclusions from the
    /// investigation.
    content: []const u8,

    /// User feedback for this investigation result. This contains the user's
    /// assessment and comments about the quality and usefulness of the
    /// investigation findings.
    feedback: ?InvestigationFeedback,

    /// The unique identifier for this investigation action. This ID is used to
    /// track and reference the specific investigation throughout its lifecycle.
    investigation_id: []const u8,

    /// ISO 8601 timestamp of the most recent status update. This indicates when the
    /// investigation was last modified or when its status last changed.
    last_updated: i64,

    /// The current execution status of the investigation. This indicates whether
    /// the investigation is pending, in progress, completed, or failed.
    status: ExecutionStatus,

    /// Human-readable summary of the investigation focus. This provides a brief
    /// description of what the investigation is examining or analyzing.
    title: []const u8,

    pub const json_field_names = .{
        .action_type = "actionType",
        .content = "content",
        .feedback = "feedback",
        .investigation_id = "investigationId",
        .last_updated = "lastUpdated",
        .status = "status",
        .title = "title",
    };
};
