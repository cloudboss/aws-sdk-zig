/// Input for creating a semantic memory strategy.
pub const SemanticMemoryStrategyInput = struct {
    /// The description of the semantic memory strategy.
    description: ?[]const u8 = null,

    /// The name of the semantic memory strategy.
    name: []const u8,

    /// The namespaces associated with the semantic memory strategy.
    namespaces: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
    };
};
