/// Represents a directional edge in a directed acyclic graph (DAG).
pub const CodeGenEdge = struct {
    /// The ID of the node at which the edge starts.
    source: []const u8,

    /// The ID of the node at which the edge ends.
    target: []const u8,

    /// The target of the edge.
    target_parameter: ?[]const u8,

    pub const json_field_names = .{
        .source = "Source",
        .target = "Target",
        .target_parameter = "TargetParameter",
    };
};
