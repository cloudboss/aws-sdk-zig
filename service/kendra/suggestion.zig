const SourceDocument = @import("source_document.zig").SourceDocument;
const SuggestionValue = @import("suggestion_value.zig").SuggestionValue;

/// A single query suggestion.
pub const Suggestion = struct {
    /// The UUID (universally unique identifier) of a single
    /// query suggestion.
    id: ?[]const u8,

    /// The list of document IDs and their fields/attributes that are used for a
    /// single query suggestion, if document fields set to use for query
    /// suggestions.
    source_documents: ?[]const SourceDocument,

    /// The value for the UUID (universally unique identifier)
    /// of a single query suggestion.
    ///
    /// The value is the text string of a suggestion.
    value: ?SuggestionValue,

    pub const json_field_names = .{
        .id = "Id",
        .source_documents = "SourceDocuments",
        .value = "Value",
    };
};
