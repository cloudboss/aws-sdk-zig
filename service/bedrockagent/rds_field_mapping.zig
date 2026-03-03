/// Contains the names of the fields to which to map information about the
/// vector store.
pub const RdsFieldMapping = struct {
    /// Provide a name for the universal metadata field where Amazon Bedrock will
    /// store any custom metadata from your data source.
    custom_metadata_field: ?[]const u8 = null,

    /// The name of the field in which Amazon Bedrock stores metadata about the
    /// vector store.
    metadata_field: []const u8,

    /// The name of the field in which Amazon Bedrock stores the ID for each entry.
    primary_key_field: []const u8,

    /// The name of the field in which Amazon Bedrock stores the raw text from your
    /// data. The text is split according to the chunking strategy you choose.
    text_field: []const u8,

    /// The name of the field in which Amazon Bedrock stores the vector embeddings
    /// for your data sources.
    vector_field: []const u8,

    pub const json_field_names = .{
        .custom_metadata_field = "customMetadataField",
        .metadata_field = "metadataField",
        .primary_key_field = "primaryKeyField",
        .text_field = "textField",
        .vector_field = "vectorField",
    };
};
