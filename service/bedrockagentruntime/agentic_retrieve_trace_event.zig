const AgenticRetrieveTraceEventAttributes = @import("agentic_retrieve_trace_event_attributes.zig").AgenticRetrieveTraceEventAttributes;

/// A trace event providing visibility into the agentic retrieval process.
pub const AgenticRetrieveTraceEvent = struct {
    /// The attributes describing the trace event details.
    attributes: AgenticRetrieveTraceEventAttributes,

    /// The unique identifier of the trace event.
    id: []const u8,

    /// The timestamp when the trace event occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .attributes = "attributes",
        .id = "id",
        .timestamp = "timestamp",
    };
};
