const Relevance = @import("relevance.zig").Relevance;

/// Overrides the document relevance properties of a custom index field.
pub const DocumentRelevanceConfiguration = struct {
    /// The name of the index field.
    name: []const u8,

    /// Provides information for tuning the relevance of a field in a search. When a
    /// query
    /// includes terms that match the field, the results are given a boost in the
    /// response based on
    /// these tuning parameters.
    relevance: Relevance,

    pub const json_field_names = .{
        .name = "Name",
        .relevance = "Relevance",
    };
};
