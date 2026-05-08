const aws = @import("aws");

const MemoryContent = @import("memory_content.zig").MemoryContent;
const MemoryRecordMetadataValue = @import("memory_record_metadata_value.zig").MemoryRecordMetadataValue;

/// Input structure to update an existing memory record.
pub const MemoryRecordUpdateInput = struct {
    /// The content to be stored within the memory record.
    content: ?MemoryContent = null,

    /// The unique ID of the memory record to be updated.
    memory_record_id: []const u8,

    /// The updated ID of the memory strategy that defines how this memory record is
    /// grouped.
    memory_strategy_id: ?[]const u8 = null,

    /// Metadata key-value pairs to be stored with the memory record.
    metadata: ?[]const aws.map.MapEntry(MemoryRecordMetadataValue) = null,

    /// The updated list of namespace identifiers for categorizing the memory
    /// record.
    namespaces: ?[]const []const u8 = null,

    /// Time at which the memory record was updated
    timestamp: i64,

    pub const json_field_names = .{
        .content = "content",
        .memory_record_id = "memoryRecordId",
        .memory_strategy_id = "memoryStrategyId",
        .metadata = "metadata",
        .namespaces = "namespaces",
        .timestamp = "timestamp",
    };
};
