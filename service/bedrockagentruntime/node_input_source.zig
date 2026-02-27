/// Represents the source of input data for a node field.
pub const NodeInputSource = struct {
    /// The expression used to extract data from the source.
    expression: []const u8,

    /// The name of the source node that provides the input data.
    node_name: []const u8,

    /// The name of the output field from the source node.
    output_field_name: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
        .node_name = "nodeName",
        .output_field_name = "outputFieldName",
    };
};
