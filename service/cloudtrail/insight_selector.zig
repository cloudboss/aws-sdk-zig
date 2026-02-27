const SourceEventCategory = @import("source_event_category.zig").SourceEventCategory;
const InsightType = @import("insight_type.zig").InsightType;

/// A JSON string that contains a list of Insights types that are logged on a
/// trail or event data store.
pub const InsightSelector = struct {
    /// Select the event category on which Insights should be enabled.
    ///
    /// * If EventCategories is not provided, the specified Insights types are
    ///   enabled on management API calls by default.
    ///
    /// * If EventCategories is provided, the given event categories will overwrite
    ///   the existing ones. For example,
    /// if a trail already has Insights enabled on management events, and then a
    /// PutInsightSelectors request is made with only data events specified in
    /// EventCategories, Insights on management events will be disabled.
    event_categories: ?[]const SourceEventCategory,

    /// The type of Insights events to log on a trail or event data store.
    /// `ApiCallRateInsight` and
    /// `ApiErrorRateInsight` are valid Insight types.
    ///
    /// The `ApiCallRateInsight` Insights type analyzes write-only
    /// management API calls or read and write data API calls that are aggregated
    /// per minute against a baseline API call volume.
    ///
    /// The `ApiErrorRateInsight` Insights type analyzes management and data
    /// API calls that result in error codes. The error is shown if the API call is
    /// unsuccessful.
    insight_type: ?InsightType,

    pub const json_field_names = .{
        .event_categories = "EventCategories",
        .insight_type = "InsightType",
    };
};
