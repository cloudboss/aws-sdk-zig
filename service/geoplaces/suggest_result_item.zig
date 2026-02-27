const SuggestHighlights = @import("suggest_highlights.zig").SuggestHighlights;
const SuggestPlaceResult = @import("suggest_place_result.zig").SuggestPlaceResult;
const SuggestQueryResult = @import("suggest_query_result.zig").SuggestQueryResult;
const SuggestResultItemType = @import("suggest_result_item_type.zig").SuggestResultItemType;

/// The resulting item from the suggested query.
pub const SuggestResultItem = struct {
    /// Describes how the parts of the response element matched the input query by
    /// returning the sections of the response which matched to input query terms.
    highlights: ?SuggestHighlights,

    /// The suggested place by its unique ID.
    place: ?SuggestPlaceResult,

    query: ?SuggestQueryResult,

    /// The result type. Place results represent the final result for a point of
    /// interest, Query results represent a follow up query which can be completed
    /// through the SearchText operation.
    suggest_result_item_type: SuggestResultItemType,

    /// The display title that should be used when presenting this option to the end
    /// user.
    title: []const u8,

    pub const json_field_names = .{
        .highlights = "Highlights",
        .place = "Place",
        .query = "Query",
        .suggest_result_item_type = "SuggestResultItemType",
        .title = "Title",
    };
};
