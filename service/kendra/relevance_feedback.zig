const RelevanceType = @import("relevance_type.zig").RelevanceType;

/// Provides feedback on how relevant a document is to a search. Your
/// application uses the
/// `SubmitFeedback` API to provide relevance information.
pub const RelevanceFeedback = struct {
    /// Whether the document was relevant or not relevant to the search.
    relevance_value: RelevanceType,

    /// The identifier of the search result that the user provided relevance
    /// feedback
    /// for.
    result_id: []const u8,

    pub const json_field_names = .{
        .relevance_value = "RelevanceValue",
        .result_id = "ResultId",
    };
};
