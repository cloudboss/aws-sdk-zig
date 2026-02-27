/// Left expression of the event metadata filter.
pub const LeftExpression = union(enum) {
    /// Key associated with the metadata in an event.
    metadata_key: ?[]const u8,

    pub const json_field_names = .{
        .metadata_key = "metadataKey",
    };
};
