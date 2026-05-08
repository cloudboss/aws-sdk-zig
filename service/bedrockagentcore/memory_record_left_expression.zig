/// The left-hand side of a memory record metadata filter expression.
pub const MemoryRecordLeftExpression = union(enum) {
    /// The metadata key to filter on.
    metadata_key: ?[]const u8,

    pub const json_field_names = .{
        .metadata_key = "metadataKey",
    };
};
