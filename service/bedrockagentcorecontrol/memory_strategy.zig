const StrategyConfiguration = @import("strategy_configuration.zig").StrategyConfiguration;
const MemoryStrategyStatus = @import("memory_strategy_status.zig").MemoryStrategyStatus;
const MemoryStrategyType = @import("memory_strategy_type.zig").MemoryStrategyType;

/// Contains information about a memory strategy.
pub const MemoryStrategy = struct {
    /// The configuration of the memory strategy.
    configuration: ?StrategyConfiguration,

    /// The timestamp when the memory strategy was created.
    created_at: ?i64,

    /// The description of the memory strategy.
    description: ?[]const u8,

    /// The name of the memory strategy.
    name: []const u8,

    /// The namespaces associated with the memory strategy.
    namespaces: []const []const u8,

    /// The current status of the memory strategy.
    status: ?MemoryStrategyStatus,

    /// The unique identifier of the memory strategy.
    strategy_id: []const u8,

    /// The type of the memory strategy.
    @"type": MemoryStrategyType,

    /// The timestamp when the memory strategy was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .configuration = "configuration",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
        .status = "status",
        .strategy_id = "strategyId",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
