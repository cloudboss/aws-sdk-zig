const aws = @import("aws");

const MemoryContent = @import("memory_content.zig").MemoryContent;
const MetadataValue = @import("metadata_value.zig").MetadataValue;

/// Contains summary information about a memory record.
pub const MemoryRecordSummary = struct {
    /// The content of the memory record.
    content: MemoryContent,

    /// The timestamp when the memory record was created.
    created_at: i64,

    /// The unique identifier of the memory record.
    memory_record_id: []const u8,

    /// The identifier of the memory strategy associated with this record.
    memory_strategy_id: []const u8,

    /// A map of metadata key-value pairs associated with a memory record.
    metadata: ?[]const aws.map.MapEntry(MetadataValue),

    /// The namespaces associated with this memory record.
    namespaces: []const []const u8,

    /// The relevance score of the memory record when returned as part of a search
    /// result. Higher values indicate greater relevance to the search query.
    score: ?f64,

    pub const json_field_names = .{
        .content = "content",
        .created_at = "createdAt",
        .memory_record_id = "memoryRecordId",
        .memory_strategy_id = "memoryStrategyId",
        .metadata = "metadata",
        .namespaces = "namespaces",
        .score = "score",
    };
};
