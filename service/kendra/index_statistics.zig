const FaqStatistics = @import("faq_statistics.zig").FaqStatistics;
const TextDocumentStatistics = @import("text_document_statistics.zig").TextDocumentStatistics;

/// Provides information about the number of documents and the number of
/// questions and answers
/// in an index.
pub const IndexStatistics = struct {
    /// The number of question and answer topics in the index.
    faq_statistics: FaqStatistics,

    /// The number of text documents indexed.
    text_document_statistics: TextDocumentStatistics,

    pub const json_field_names = .{
        .faq_statistics = "FaqStatistics",
        .text_document_statistics = "TextDocumentStatistics",
    };
};
