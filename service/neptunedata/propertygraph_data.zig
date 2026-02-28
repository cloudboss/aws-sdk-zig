/// A Gremlin or openCypher change record.
pub const PropertygraphData = struct {
    /// If this is an edge (type = `e`), the ID of the corresponding `from` vertex
    /// or source node.
    from: ?[]const u8,

    /// The ID of the Gremlin or openCypher element.
    id: []const u8,

    /// The property name. For element labels, this is `label`.
    key: []const u8,

    /// If this is an edge (type = `e`), the ID of the corresponding `to` vertex or
    /// target node.
    to: ?[]const u8,

    /// The type of this Gremlin or openCypher element. Must be one of:
    ///
    /// * ** `v1` **   -   Vertex label for Gremlin, or node label for openCypher.
    /// * ** `vp` **   -   Vertex properties for Gremlin, or node properties for
    ///   openCypher.
    /// * ** `e` **   -   Edge and edge label for Gremlin, or relationship and
    ///   relationship type for openCypher.
    /// * ** `ep` **   -   Edge properties for Gremlin, or relationship properties
    ///   for openCypher.
    @"type": []const u8,

    /// This is a JSON object that contains a value field for the value itself, and
    /// a datatype field for the JSON data type of that value:
    value: []const u8,

    pub const json_field_names = .{
        .from = "from",
        .id = "id",
        .key = "key",
        .to = "to",
        .@"type" = "type",
        .value = "value",
    };
};
