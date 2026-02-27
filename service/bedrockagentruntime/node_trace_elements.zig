const TracePart = @import("trace_part.zig").TracePart;

/// Contains trace elements for node execution tracking.
pub const NodeTraceElements = union(enum) {
    /// Agent trace information for the node execution.
    agent_traces: ?[]const TracePart,

    pub const json_field_names = .{
        .agent_traces = "agentTraces",
    };
};
