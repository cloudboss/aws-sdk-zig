/// Specifies a field to be used during the reranking process in a Knowledge
/// Base vector search. This structure identifies metadata fields that should be
/// considered when reordering search results to improve relevance.
pub const FieldForReranking = struct {
    /// The name of the metadata field to be used during the reranking process.
    field_name: []const u8,

    pub const json_field_names = .{
        .field_name = "fieldName",
    };
};
