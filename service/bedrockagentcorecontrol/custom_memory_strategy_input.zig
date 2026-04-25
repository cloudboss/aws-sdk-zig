const CustomConfigurationInput = @import("custom_configuration_input.zig").CustomConfigurationInput;

/// Input for creating a custom memory strategy.
pub const CustomMemoryStrategyInput = struct {
    /// The configuration for the custom memory strategy.
    configuration: ?CustomConfigurationInput = null,

    /// The description of the custom memory strategy.
    description: ?[]const u8 = null,

    /// The name of the custom memory strategy.
    name: []const u8,

    /// The namespaces associated with the custom memory strategy.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates associated with the custom memory strategy.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
