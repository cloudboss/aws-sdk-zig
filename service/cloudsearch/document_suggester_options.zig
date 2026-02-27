const SuggesterFuzzyMatching = @import("suggester_fuzzy_matching.zig").SuggesterFuzzyMatching;

/// Options for a search suggester.
pub const DocumentSuggesterOptions = struct {
    /// The level of fuzziness allowed when suggesting matches for a string: `none`,
    /// `low`, or `high`. With none, the specified string is treated as an exact
    /// prefix. With low, suggestions must differ from the specified string by no
    /// more than one character. With high, suggestions can differ by up to two
    /// characters. The default is none.
    fuzzy_matching: ?SuggesterFuzzyMatching,

    /// An expression that computes a score for each suggestion to control how they
    /// are sorted. The scores are rounded to the nearest
    /// integer, with a floor of 0 and a ceiling of 2^31-1. A document's relevance
    /// score is not computed
    /// for suggestions, so sort expressions cannot reference the `_score` value.
    /// To sort suggestions using a numeric field or existing expression, simply
    /// specify
    /// the name of the field or expression. If no expression is configured for the
    /// suggester, the
    /// suggestions are sorted with the closest matches listed first.
    sort_expression: ?[]const u8,

    /// The name of the index field you want to use for suggestions.
    source_field: []const u8,
};
