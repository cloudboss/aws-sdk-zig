const MessageInsightsFilters = @import("message_insights_filters.zig").MessageInsightsFilters;

/// An object that contains filters applied when performing the Message Insights
/// export.
pub const MessageInsightsDataSource = struct {
    /// Represents the end date for the export interval as a timestamp. The end date
    /// is inclusive.
    end_date: i64,

    /// Filters for results to be excluded from the export file.
    exclude: ?MessageInsightsFilters,

    /// Filters for results to be included in the export file.
    include: ?MessageInsightsFilters,

    /// The maximum number of results.
    max_results: ?i32,

    /// Represents the start date for the export interval as a timestamp. The start
    /// date is inclusive.
    start_date: i64,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .exclude = "Exclude",
        .include = "Include",
        .max_results = "MaxResults",
        .start_date = "StartDate",
    };
};
