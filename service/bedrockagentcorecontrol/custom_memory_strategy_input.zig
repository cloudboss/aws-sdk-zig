const CustomConfigurationInput = @import("custom_configuration_input.zig").CustomConfigurationInput;

/// Input for creating a custom memory strategy.
pub const CustomMemoryStrategyInput = struct {
    /// The configuration for the custom memory strategy.
    configuration: ?CustomConfigurationInput,

    /// The description of the custom memory strategy.
    description: ?[]const u8,

    /// The name of the custom memory strategy.
    name: []const u8,

    /// The namespaces associated with the custom memory strategy.
    namespaces: ?[]const []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
    };
};
