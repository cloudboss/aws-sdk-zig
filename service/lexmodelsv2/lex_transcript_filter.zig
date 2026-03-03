const DateRangeFilter = @import("date_range_filter.zig").DateRangeFilter;

/// The object that contains transcript filter details that are
/// associated with a bot recommendation.
pub const LexTranscriptFilter = struct {
    /// The object that contains a date range filter that will be applied to
    /// the transcript. Specify this object if you want Amazon Lex to only read the
    /// files that are within the date range.
    date_range_filter: ?DateRangeFilter = null,

    pub const json_field_names = .{
        .date_range_filter = "dateRangeFilter",
    };
};
