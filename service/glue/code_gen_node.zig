const CodeGenNodeArg = @import("code_gen_node_arg.zig").CodeGenNodeArg;

/// Represents a node in a directed acyclic graph (DAG)
pub const CodeGenNode = struct {
    /// Properties of the node, in the form of name-value pairs.
    args: []const CodeGenNodeArg,

    /// A node identifier that is unique within the node's graph.
    id: []const u8,

    /// The line number of the node.
    line_number: i32 = 0,

    /// The type of node that this is.
    node_type: []const u8,

    pub const json_field_names = .{
        .args = "Args",
        .id = "Id",
        .line_number = "LineNumber",
        .node_type = "NodeType",
    };
};
