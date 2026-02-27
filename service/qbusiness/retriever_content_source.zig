/// Specifies a retriever as the content source for a search.
pub const RetrieverContentSource = struct {
    /// The unique identifier of the retriever to use as the content source.
    retriever_id: []const u8,

    pub const json_field_names = .{
        .retriever_id = "retrieverId",
    };
};
