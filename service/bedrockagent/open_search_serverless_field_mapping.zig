/// Contains the names of the fields to which to map information about the
/// vector store.
pub const OpenSearchServerlessFieldMapping = struct {
    /// The name of the field in which Amazon Bedrock stores metadata about the
    /// vector store.
    metadata_field: []const u8,

    /// The name of the field in which Amazon Bedrock stores the raw text from your
    /// data. The text is split according to the chunking strategy you choose.
    text_field: []const u8,

    /// The name of the field in which Amazon Bedrock stores the vector embeddings
    /// for your data sources.
    vector_field: []const u8,

    pub const json_field_names = .{
        .metadata_field = "metadataField",
        .text_field = "textField",
        .vector_field = "vectorField",
    };
};
