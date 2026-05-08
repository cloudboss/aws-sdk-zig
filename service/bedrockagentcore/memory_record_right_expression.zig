const MemoryRecordMetadataValue = @import("memory_record_metadata_value.zig").MemoryRecordMetadataValue;

/// The right-hand side of a memory record metadata filter expression.
pub const MemoryRecordRightExpression = union(enum) {
    /// The metadata value to compare against.
    metadata_value: ?MemoryRecordMetadataValue,

    pub const json_field_names = .{
        .metadata_value = "metadataValue",
    };
};
