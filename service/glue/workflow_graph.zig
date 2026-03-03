const Edge = @import("edge.zig").Edge;
const Node = @import("node.zig").Node;

/// A workflow graph represents the complete workflow containing all the Glue
/// components present in the
/// workflow and all the directed connections between them.
pub const WorkflowGraph = struct {
    /// A list of all the directed connections between the nodes belonging to the
    /// workflow.
    edges: ?[]const Edge = null,

    /// A list of the the Glue components belong to the workflow represented as
    /// nodes.
    nodes: ?[]const Node = null,

    pub const json_field_names = .{
        .edges = "Edges",
        .nodes = "Nodes",
    };
};
