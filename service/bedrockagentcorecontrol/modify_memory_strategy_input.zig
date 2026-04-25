const ModifyStrategyConfiguration = @import("modify_strategy_configuration.zig").ModifyStrategyConfiguration;

/// Input for modifying a memory strategy.
pub const ModifyMemoryStrategyInput = struct {
    /// The updated configuration for the memory strategy.
    configuration: ?ModifyStrategyConfiguration = null,

    /// The updated description of the memory strategy.
    description: ?[]const u8 = null,

    /// The unique identifier of the memory strategy to modify.
    memory_strategy_id: []const u8,

    /// The updated namespaces for the memory strategy.
    namespaces: ?[]const []const u8 = null,

    /// The updated namespaceTemplates for the memory strategy.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .description = "description",
        .memory_strategy_id = "memoryStrategyId",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
