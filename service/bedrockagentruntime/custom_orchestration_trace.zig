const CustomOrchestrationTraceEvent = @import("custom_orchestration_trace_event.zig").CustomOrchestrationTraceEvent;

/// The trace behavior for the custom orchestration.
pub const CustomOrchestrationTrace = struct {
    /// The event details used with the custom orchestration.
    event: ?CustomOrchestrationTraceEvent,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8,

    pub const json_field_names = .{
        .event = "event",
        .trace_id = "traceId",
    };
};
