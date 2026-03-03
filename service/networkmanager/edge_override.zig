/// Describes the edge that's used for the override.
pub const EdgeOverride = struct {
    /// The list of edge locations.
    edge_sets: ?[]const []const []const u8 = null,

    /// The edge that should be used when overriding the current edge order.
    use_edge: ?[]const u8 = null,

    pub const json_field_names = .{
        .edge_sets = "EdgeSets",
        .use_edge = "UseEdge",
    };
};
