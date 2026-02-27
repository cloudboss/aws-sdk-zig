/// Value associated with the `eventMetadata` key.
pub const MetadataValue = union(enum) {
    /// Value associated with the `eventMetadata` key.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .string_value = "stringValue",
    };
};
