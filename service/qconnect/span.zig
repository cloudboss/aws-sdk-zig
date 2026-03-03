const SpanAttributes = @import("span_attributes.zig").SpanAttributes;
const SpanType = @import("span_type.zig").SpanType;
const SpanStatus = @import("span_status.zig").SpanStatus;

/// A span represents a unit of work during AI agent execution, capturing
/// timing, status, and contextual attributes.
pub const Span = struct {
    /// UUID of the Connect AI Assistant resource
    assistant_id: []const u8,

    /// Span-specific contextual attributes
    attributes: SpanAttributes,

    /// Operation end time in milliseconds since epoch
    end_timestamp: i64,

    /// Parent span identifier for hierarchy. Null for root spans.
    parent_span_id: ?[]const u8 = null,

    /// The service request ID that initiated the operation
    request_id: []const u8,

    /// UUID of the Connect AI Session resource
    session_id: []const u8,

    /// Unique span identifier
    span_id: []const u8,

    /// Service-defined operation name
    span_name: []const u8,

    /// Operation relationship type
    span_type: SpanType,

    /// Operation start time in milliseconds since epoch
    start_timestamp: i64,

    /// Span completion status
    status: SpanStatus,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .attributes = "attributes",
        .end_timestamp = "endTimestamp",
        .parent_span_id = "parentSpanId",
        .request_id = "requestId",
        .session_id = "sessionId",
        .span_id = "spanId",
        .span_name = "spanName",
        .span_type = "spanType",
        .start_timestamp = "startTimestamp",
        .status = "status",
    };
};
