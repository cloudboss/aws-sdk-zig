const TraceElements = @import("trace_elements.zig").TraceElements;

/// Contains information about a dependency trace event in the flow.
pub const FlowTraceDependencyEvent = struct {
    /// The name of the node that generated the dependency trace.
    node_name: []const u8,

    /// The date and time that the dependency trace was generated.
    timestamp: i64,

    /// The trace elements containing detailed information about the dependency.
    trace_elements: TraceElements,

    pub const json_field_names = .{
        .node_name = "nodeName",
        .timestamp = "timestamp",
        .trace_elements = "traceElements",
    };
};
