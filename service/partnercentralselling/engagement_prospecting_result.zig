const ProspectingTaskStatus = @import("prospecting_task_status.zig").ProspectingTaskStatus;

/// Contains the result of processing a single engagement within a prospecting
/// task. Each engagement is processed independently, so individual engagements
/// can succeed or fail regardless of other engagements in the same task.
pub const EngagementProspectingResult = struct {
    /// The identifier of the prospecting context created for this engagement. This
    /// field is only populated when the engagement was processed successfully
    /// (status is `COMPLETED`). Use this identifier to reference the prospecting
    /// context in subsequent operations.
    engagement_context_id: ?[]const u8 = null,

    /// The unique identifier of the engagement that was processed.
    engagement_identifier: []const u8,

    /// A human-readable description of the failure for this engagement, including
    /// suggested recovery steps. This field is only populated when `Status` is
    /// `FAILED`.
    message: ?[]const u8 = null,

    /// An enumerated code indicating the reason this engagement failed to process.
    /// This field is only populated when `Status` is `FAILED`.
    reason_code: ?[]const u8 = null,

    /// The processing status of this specific engagement. Possible values are
    /// `PENDING`, `IN_PROGRESS`, `COMPLETED`, and `FAILED`.
    status: ProspectingTaskStatus,

    pub const json_field_names = .{
        .engagement_context_id = "EngagementContextId",
        .engagement_identifier = "EngagementIdentifier",
        .message = "Message",
        .reason_code = "ReasonCode",
        .status = "Status",
    };
};
