const aws = @import("aws");

const MemoryContent = @import("memory_content.zig").MemoryContent;
const MemoryRecordMetadataValue = @import("memory_record_metadata_value.zig").MemoryRecordMetadataValue;

/// Contains information about a memory record in an AgentCore Memory resource.
pub const MemoryRecord = struct {
    /// The content of the memory record.
    content: MemoryContent,

    /// The timestamp when the memory record was created.
    created_at: i64,

    /// The timestamp at which the memory record expires and becomes eligible for
    /// deletion. This value is set when a record expiry (long-term memory
    /// time-to-live) applies to the record, either from the strategy the record
    /// belongs to or from a record expiry provided on the batch request that
    /// created or updated it. If the record has no expiry configured, this value is
    /// not present and the record does not expire.
    expires_at: ?i64 = null,

    /// The unique identifier of the memory record.
    memory_record_id: []const u8,

    /// The identifier of the memory strategy associated with this record.
    memory_strategy_id: []const u8,

    /// A map of metadata key-value pairs associated with a memory record.
    metadata: ?[]const aws.map.MapEntry(MemoryRecordMetadataValue) = null,

    /// The namespaces associated with this memory record. Namespaces help organize
    /// and categorize memory records.
    namespaces: []const []const u8,

    /// The timestamp based on which the memory record was ingested. This reflects
    /// the time of the source content that the record was derived from, which can
    /// differ from `createdAt`, the time the record itself was written.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .content = "content",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .memory_record_id = "memoryRecordId",
        .memory_strategy_id = "memoryStrategyId",
        .metadata = "metadata",
        .namespaces = "namespaces",
        .timestamp = "timestamp",
    };
};
