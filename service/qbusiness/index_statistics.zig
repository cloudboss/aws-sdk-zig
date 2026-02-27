const TextDocumentStatistics = @import("text_document_statistics.zig").TextDocumentStatistics;

/// Provides information about the number of documents in an index.
pub const IndexStatistics = struct {
    /// The number of documents indexed.
    text_document_statistics: ?TextDocumentStatistics,

    pub const json_field_names = .{
        .text_document_statistics = "textDocumentStatistics",
    };
};
