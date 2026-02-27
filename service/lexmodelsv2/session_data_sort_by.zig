const AnalyticsSessionSortByName = @import("analytics_session_sort_by_name.zig").AnalyticsSessionSortByName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;

/// An object specifying the measure and method by which to sort the session
/// analytics data.
pub const SessionDataSortBy = struct {
    /// The measure by which to sort the session analytics data.
    ///
    /// * `conversationStartTime` – The date and time when the conversation began. A
    ///   conversation is defined as a unique combination of a `sessionId` and an
    ///   `originatingRequestId`.
    ///
    /// * `numberOfTurns` – The number of turns that the session took.
    ///
    /// * `conversationDurationSeconds` – The duration of the conversation in
    ///   seconds.
    name: AnalyticsSessionSortByName,

    /// Specifies whether to sort the results in ascending or descending order.
    order: AnalyticsSortOrder,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
    };
};
