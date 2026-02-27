const MemoryStrategyInput = @import("memory_strategy_input.zig").MemoryStrategyInput;
const DeleteMemoryStrategyInput = @import("delete_memory_strategy_input.zig").DeleteMemoryStrategyInput;
const ModifyMemoryStrategyInput = @import("modify_memory_strategy_input.zig").ModifyMemoryStrategyInput;

/// Contains information for modifying memory strategies.
pub const ModifyMemoryStrategies = struct {
    /// The list of memory strategies to add.
    add_memory_strategies: ?[]const MemoryStrategyInput,

    /// The list of memory strategies to delete.
    delete_memory_strategies: ?[]const DeleteMemoryStrategyInput,

    /// The list of memory strategies to modify.
    modify_memory_strategies: ?[]const ModifyMemoryStrategyInput,

    pub const json_field_names = .{
        .add_memory_strategies = "addMemoryStrategies",
        .delete_memory_strategies = "deleteMemoryStrategies",
        .modify_memory_strategies = "modifyMemoryStrategies",
    };
};
