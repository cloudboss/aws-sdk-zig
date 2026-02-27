const RetrieverContentSource = @import("retriever_content_source.zig").RetrieverContentSource;

/// Specifies the source of content to search in.
pub const ContentSource = union(enum) {
    /// The retriever to use as the content source.
    retriever: ?RetrieverContentSource,

    pub const json_field_names = .{
        .retriever = "retriever",
    };
};
