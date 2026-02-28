const aws = @import("aws");

/// A structure that represents a node in a dependency graph, containing
/// information about a service, resource, or other entity and its
/// characteristics.
pub const Node = struct {
    /// The duration or processing time associated with this node, if applicable.
    duration: ?f64,

    /// The key attributes that identify this node, including Type, Name, and
    /// Environment information.
    key_attributes: []const aws.map.StringMapEntry,

    /// The name of the entity represented by this node.
    name: []const u8,

    /// A unique identifier for this node within the dependency graph.
    node_id: []const u8,

    /// The operation associated with this node, if applicable.
    operation: ?[]const u8,

    /// The status of the entity represented by this node.
    status: ?[]const u8,

    /// The type of entity represented by this node, such as `Service` or
    /// `Resource`.
    type: ?[]const u8,

    pub const json_field_names = .{
        .duration = "Duration",
        .key_attributes = "KeyAttributes",
        .name = "Name",
        .node_id = "NodeId",
        .operation = "Operation",
        .status = "Status",
        .type = "Type",
    };
};
