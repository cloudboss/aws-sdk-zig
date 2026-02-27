/// An edge structure.
pub const EdgeStructure = struct {
    /// The number of edges that have this specific structure.
    count: ?i64,

    /// A list of edge properties present in this specific structure.
    edge_properties: ?[]const []const u8,

    pub const json_field_names = .{
        .count = "count",
        .edge_properties = "edgeProperties",
    };
};
