const FlowCompletionReason = @import("flow_completion_reason.zig").FlowCompletionReason;

/// Contains information about why a flow completed.
pub const FlowCompletionEvent = struct {
    /// The reason that the flow completed.
    completion_reason: FlowCompletionReason,

    pub const json_field_names = .{
        .completion_reason = "completionReason",
    };
};
