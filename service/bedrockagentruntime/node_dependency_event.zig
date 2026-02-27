const NodeTraceElements = @import("node_trace_elements.zig").NodeTraceElements;

/// Contains information about an internal trace of a specific node during
/// execution.
pub const NodeDependencyEvent = struct {
    /// The name of the node that generated the dependency trace.
    node_name: []const u8,

    /// The date and time that the dependency trace was generated.
    timestamp: i64,

    /// The trace elements containing detailed information about the node execution.
    trace_elements: NodeTraceElements,

    pub const json_field_names = .{
        .node_name = "nodeName",
        .timestamp = "timestamp",
        .trace_elements = "traceElements",
    };
};
