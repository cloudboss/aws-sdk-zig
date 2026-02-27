const ScheduledQueryInsightsMode = @import("scheduled_query_insights_mode.zig").ScheduledQueryInsightsMode;

/// Encapsulates settings for enabling `QueryInsights` on an
/// `ExecuteScheduledQueryRequest`.
pub const ScheduledQueryInsights = struct {
    /// Provides the following modes to enable `ScheduledQueryInsights`:
    ///
    /// * `ENABLED_WITH_RATE_CONTROL` – Enables `ScheduledQueryInsights` for the
    ///   queries being processed. This mode also includes a rate control mechanism,
    ///   which limits the `QueryInsights` feature to 1 query per second (QPS).
    ///
    /// * `DISABLED` – Disables `ScheduledQueryInsights`.
    mode: ScheduledQueryInsightsMode,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
