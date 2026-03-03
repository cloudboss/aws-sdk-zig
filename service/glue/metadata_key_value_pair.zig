/// A structure containing a key value pair for metadata.
pub const MetadataKeyValuePair = struct {
    /// A metadata key.
    metadata_key: ?[]const u8 = null,

    /// A metadata key’s corresponding value.
    metadata_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_key = "MetadataKey",
        .metadata_value = "MetadataValue",
    };
};
