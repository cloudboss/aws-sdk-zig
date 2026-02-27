/// Input for deleting a memory strategy.
pub const DeleteMemoryStrategyInput = struct {
    /// The unique identifier of the memory strategy to delete.
    memory_strategy_id: []const u8,

    pub const json_field_names = .{
        .memory_strategy_id = "memoryStrategyId",
    };
};
