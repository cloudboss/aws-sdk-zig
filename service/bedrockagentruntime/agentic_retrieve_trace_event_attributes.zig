const AgenticRetrieveAction = @import("agentic_retrieve_action.zig").AgenticRetrieveAction;
const AgenticRetrieveFailure = @import("agentic_retrieve_failure.zig").AgenticRetrieveFailure;
const AgenticRetrieveSourceMetadata = @import("agentic_retrieve_source_metadata.zig").AgenticRetrieveSourceMetadata;
const AgenticRetrieveTraceResultItem = @import("agentic_retrieve_trace_result_item.zig").AgenticRetrieveTraceResultItem;
const AgenticRetrieveStatus = @import("agentic_retrieve_status.zig").AgenticRetrieveStatus;
const AgenticRetrieveStep = @import("agentic_retrieve_step.zig").AgenticRetrieveStep;
const AgenticRetrieveWarning = @import("agentic_retrieve_warning.zig").AgenticRetrieveWarning;

/// Attributes describing the details of an agentic retrieval trace event.
pub const AgenticRetrieveTraceEventAttributes = struct {
    /// The list of actions taken during this step.
    actions: ?[]const AgenticRetrieveAction = null,

    /// Failures that occurred during this step.
    failures: ?[]const AgenticRetrieveFailure = null,

    /// A human-readable message describing the trace event.
    message: []const u8,

    /// Metadata about the retrieval sources used.
    retrieval_metadata: ?[]const AgenticRetrieveSourceMetadata = null,

    /// The retrieval results from this step.
    retrieval_response: ?[]const AgenticRetrieveTraceResultItem = null,

    /// The status of the current step.
    status: AgenticRetrieveStatus,

    /// The current step in the retrieval process.
    step: AgenticRetrieveStep,

    /// Warnings generated during this step.
    warnings: ?[]const AgenticRetrieveWarning = null,

    pub const json_field_names = .{
        .actions = "actions",
        .failures = "failures",
        .message = "message",
        .retrieval_metadata = "retrievalMetadata",
        .retrieval_response = "retrievalResponse",
        .status = "status",
        .step = "step",
        .warnings = "warnings",
    };
};
