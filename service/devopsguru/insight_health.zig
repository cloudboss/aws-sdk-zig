/// Information about the number of open reactive and proactive insights that
/// can be used
/// to gauge the health of your system.
pub const InsightHealth = struct {
    /// The Meant Time to Recover (MTTR) for the insight.
    mean_time_to_recover_in_milliseconds: ?i64 = null,

    /// The number of open proactive insights.
    open_proactive_insights: i32 = 0,

    /// The number of open reactive insights.
    open_reactive_insights: i32 = 0,

    pub const json_field_names = .{
        .mean_time_to_recover_in_milliseconds = "MeanTimeToRecoverInMilliseconds",
        .open_proactive_insights = "OpenProactiveInsights",
        .open_reactive_insights = "OpenReactiveInsights",
    };
};
