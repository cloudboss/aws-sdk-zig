const AnalyticsUtteranceSortByName = @import("analytics_utterance_sort_by_name.zig").AnalyticsUtteranceSortByName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;

/// An object specifying the measure and method by which to sort the utterance
/// data.
pub const UtteranceDataSortBy = struct {
    /// The measure by which to sort the utterance analytics data.
    ///
    /// * `Count` – The number of utterances.
    ///
    /// * `UtteranceTimestamp` – The date and time of the utterance.
    name: AnalyticsUtteranceSortByName,

    /// Specifies whether to sort the results in ascending or descending order.
    order: AnalyticsSortOrder,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
    };
};
