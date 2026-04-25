/// Input for creating a summary memory strategy.
pub const SummaryMemoryStrategyInput = struct {
    /// The description of the summary memory strategy.
    description: ?[]const u8 = null,

    /// The name of the summary memory strategy.
    name: []const u8,

    /// The namespaces associated with the summary memory strategy.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates associated with the summary memory strategy.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
