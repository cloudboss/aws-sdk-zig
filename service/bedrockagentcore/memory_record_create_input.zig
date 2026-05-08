const aws = @import("aws");

const MemoryContent = @import("memory_content.zig").MemoryContent;
const MemoryRecordMetadataValue = @import("memory_record_metadata_value.zig").MemoryRecordMetadataValue;

/// Input structure to create a new memory record.
pub const MemoryRecordCreateInput = struct {
    /// The content to be stored within the memory record.
    content: MemoryContent,

    /// The ID of the memory strategy that defines how this memory record is
    /// grouped.
    memory_strategy_id: ?[]const u8 = null,

    /// Metadata key-value pairs to be stored with the memory record.
    metadata: ?[]const aws.map.MapEntry(MemoryRecordMetadataValue) = null,

    /// A list of namespace identifiers that categorize or group the memory record.
    namespaces: []const []const u8,

    /// A client-provided identifier for tracking this specific record creation
    /// request.
    request_identifier: []const u8,

    /// Time at which the memory record was created.
    timestamp: i64,

    pub const json_field_names = .{
        .content = "content",
        .memory_strategy_id = "memoryStrategyId",
        .metadata = "metadata",
        .namespaces = "namespaces",
        .request_identifier = "requestIdentifier",
        .timestamp = "timestamp",
    };
};
