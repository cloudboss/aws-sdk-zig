/// Configuration for metadata to include in recommendation responses.
pub const MetadataConfig = struct {
    /// A list of metadata column names from your Items dataset to include in the
    /// recommendation response.
    metadata_columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .metadata_columns = "MetadataColumns",
    };
};
