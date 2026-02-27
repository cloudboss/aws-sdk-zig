const TracePart = @import("trace_part.zig").TracePart;

/// Contains trace elements for flow execution tracking.
pub const TraceElements = union(enum) {
    /// Agent trace information for the flow execution.
    agent_traces: ?[]const TracePart,

    pub const json_field_names = .{
        .agent_traces = "agentTraces",
    };
};
