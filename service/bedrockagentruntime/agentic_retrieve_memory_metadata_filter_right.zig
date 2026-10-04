const AgenticRetrieveMemoryMetadataValue = @import("agentic_retrieve_memory_metadata_value.zig").AgenticRetrieveMemoryMetadataValue;

/// The right operand of a metadata filter expression. Set exactly one member.
pub const AgenticRetrieveMemoryMetadataFilterRight = union(enum) {
    /// The value to compare the metadata key against.
    metadata_value: ?AgenticRetrieveMemoryMetadataValue,

    pub const json_field_names = .{
        .metadata_value = "metadataValue",
    };
};
