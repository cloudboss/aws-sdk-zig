const aws = @import("aws");

const EdgeStructure = @import("edge_structure.zig").EdgeStructure;
const NodeStructure = @import("node_structure.zig").NodeStructure;

/// Summary information about the graph.
pub const GraphDataSummary = struct {
    /// A list of the edge labels in the graph.
    edge_labels: ?[]const []const u8,

    /// A list of the distinct edge properties in the graph, along with the count of
    /// edges where each property is used.
    edge_properties: ?[]const []const aws.map.MapEntry(i64),

    /// This field is only present when the requested mode is DETAILED. It contains
    /// a list of edge structures.
    edge_structures: ?[]const EdgeStructure,

    /// A list of distinct node labels in the graph.
    node_labels: ?[]const []const u8,

    /// A list of the distinct node properties in the graph, along with the count of
    /// nodes where each property is used.
    node_properties: ?[]const []const aws.map.MapEntry(i64),

    /// This field is only present when the requested mode is DETAILED. It contains
    /// a list of node structures.
    node_structures: ?[]const NodeStructure,

    /// The number of unique edge labels in the graph.
    num_edge_labels: ?i64,

    /// The number of edge properties in the graph.
    num_edge_properties: ?i64,

    /// The number of edges in the graph.
    num_edges: ?i64,

    /// The number of distinct node labels in the graph.
    num_node_labels: ?i64,

    /// The number of distinct node properties in the graph.
    num_node_properties: ?i64,

    /// The number of nodes in the graph.
    num_nodes: ?i64,

    /// The total number of usages of all edge properties.
    total_edge_property_values: ?i64,

    /// The total number of usages of all node properties.
    total_node_property_values: ?i64,

    pub const json_field_names = .{
        .edge_labels = "edgeLabels",
        .edge_properties = "edgeProperties",
        .edge_structures = "edgeStructures",
        .node_labels = "nodeLabels",
        .node_properties = "nodeProperties",
        .node_structures = "nodeStructures",
        .num_edge_labels = "numEdgeLabels",
        .num_edge_properties = "numEdgeProperties",
        .num_edges = "numEdges",
        .num_node_labels = "numNodeLabels",
        .num_node_properties = "numNodeProperties",
        .num_nodes = "numNodes",
        .total_edge_property_values = "totalEdgePropertyValues",
        .total_node_property_values = "totalNodePropertyValues",
    };
};
