const Correction = @import("correction.zig").Correction;

/// A query with suggested spell corrections.
pub const SpellCorrectedQuery = struct {
    /// The corrected misspelled word or words in a query.
    corrections: ?[]const Correction,

    /// The query with the suggested spell corrections.
    suggested_query_text: ?[]const u8,

    pub const json_field_names = .{
        .corrections = "Corrections",
        .suggested_query_text = "SuggestedQueryText",
    };
};
