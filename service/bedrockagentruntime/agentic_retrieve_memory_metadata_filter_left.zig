/// The left operand of a metadata filter expression. Set exactly one member.
pub const AgenticRetrieveMemoryMetadataFilterLeft = union(enum) {
    /// The metadata key to filter on.
    metadata_key: ?[]const u8,

    pub const json_field_names = .{
        .metadata_key = "metadataKey",
    };
};
