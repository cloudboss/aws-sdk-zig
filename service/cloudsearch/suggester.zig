const DocumentSuggesterOptions = @import("document_suggester_options.zig").DocumentSuggesterOptions;

/// Configuration information for a search suggester. Each suggester has a
/// unique name and specifies the text field you want to use for suggestions.
/// The following options can be configured for a suggester: `FuzzyMatching`,
/// `SortExpression`.
pub const Suggester = struct {
    document_suggester_options: DocumentSuggesterOptions,

    suggester_name: []const u8,
};
