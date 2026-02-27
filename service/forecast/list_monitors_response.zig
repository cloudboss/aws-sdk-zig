const MonitorSummary = @import("monitor_summary.zig").MonitorSummary;

pub const ListMonitorsResponse = struct {
    /// An array of objects that summarize each monitor's properties.
    monitors: ?[]const MonitorSummary,

    /// If the response is truncated, Amazon Forecast returns this token. To
    /// retrieve the next set of
    /// results, use the token in the next request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .monitors = "Monitors",
        .next_token = "NextToken",
    };
};
