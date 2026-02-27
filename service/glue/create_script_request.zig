const CodeGenEdge = @import("code_gen_edge.zig").CodeGenEdge;
const CodeGenNode = @import("code_gen_node.zig").CodeGenNode;
const Language = @import("language.zig").Language;

pub const CreateScriptRequest = struct {
    /// A list of the edges in the DAG.
    dag_edges: ?[]const CodeGenEdge,

    /// A list of the nodes in the DAG.
    dag_nodes: ?[]const CodeGenNode,

    /// The programming language of the resulting code from the DAG.
    language: ?Language,

    pub const json_field_names = .{
        .dag_edges = "DagEdges",
        .dag_nodes = "DagNodes",
        .language = "Language",
    };
};
