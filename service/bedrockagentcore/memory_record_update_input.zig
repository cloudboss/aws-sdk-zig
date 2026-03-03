const MemoryContent = @import("memory_content.zig").MemoryContent;

/// Input structure to update an existing memory record.
pub const MemoryRecordUpdateInput = struct {
    /// The content to be stored within the memory record.
    content: ?MemoryContent = null,

    /// The unique ID of the memory record to be updated.
    memory_record_id: []const u8,

    /// The updated ID of the memory strategy that defines how this memory record is
    /// grouped.
    memory_strategy_id: ?[]const u8 = null,

    /// The updated list of namespace identifiers for categorizing the memory
    /// record.
    namespaces: ?[]const []const u8 = null,

    /// Time at which the memory record was updated
    timestamp: i64,

    pub const json_field_names = .{
        .content = "content",
        .memory_record_id = "memoryRecordId",
        .memory_strategy_id = "memoryStrategyId",
        .namespaces = "namespaces",
        .timestamp = "timestamp",
    };
};
