/// Input for creating a user preference memory strategy.
pub const UserPreferenceMemoryStrategyInput = struct {
    /// The description of the user preference memory strategy.
    description: ?[]const u8 = null,

    /// The name of the user preference memory strategy.
    name: []const u8,

    /// The namespaces associated with the user preference memory strategy.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates associated with the user preference memory strategy.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
