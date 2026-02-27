const FlowTrace = @import("flow_trace.zig").FlowTrace;

/// Contains information about a trace, which tracks an input or output for a
/// node in the flow. For more information, see [Track each step in your prompt
/// flow by viewing its trace in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceEvent = struct {
    /// The trace object containing information about an input or output for a node
    /// in the flow.
    trace: FlowTrace,

    pub const json_field_names = .{
        .trace = "trace",
    };
};
