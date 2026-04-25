const TrafficUsage = @import("traffic_usage.zig").TrafficUsage;

/// Traffic related options.
pub const RouteMatrixTrafficOptions = struct {
    /// Duration for which flow traffic is considered valid. For this period, the
    /// flow traffic is used over historical traffic data. Flow traffic refers to
    /// congestion, which changes very quickly. Duration in seconds for which flow
    /// traffic event would be considered valid. While flow traffic event is valid
    /// it will be used over the historical traffic data.
    flow_event_threshold_override: i64 = 0,

    /// Determines if traffic should be used or ignored while calculating the route.
    ///
    /// Default value: `UseTrafficData`
    usage: ?TrafficUsage = null,

    pub const json_field_names = .{
        .flow_event_threshold_override = "FlowEventThresholdOverride",
        .usage = "Usage",
    };
};
