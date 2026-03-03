const Edge = @import("edge.zig").Edge;
const Node = @import("node.zig").Node;

/// A structure that represents the dependency relationships relevant to an
/// audit finding, containing nodes and edges that show how services and
/// resources are connected.
pub const DependencyGraph = struct {
    /// An array of edges representing the connections and relationships between the
    /// nodes in the dependency graph.
    edges: ?[]const Edge = null,

    /// An array of nodes representing the services, resources, or other entities in
    /// the dependency graph.
    nodes: ?[]const Node = null,

    pub const json_field_names = .{
        .edges = "Edges",
        .nodes = "Nodes",
    };
};
