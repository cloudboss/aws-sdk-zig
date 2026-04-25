const TrafficUsage = @import("traffic_usage.zig").TrafficUsage;

/// Traffic options for the route.
pub const RouteTrafficOptions = struct {
    /// Duration for which flow traffic is considered valid. For this period, the
    /// flow traffic is used over historical traffic data. Flow traffic refers to
    /// congestion, which changes very quickly. Duration in seconds for which flow
    /// traffic event would be considered valid. While flow traffic event is valid
    /// it will be used over the historical traffic data.
    flow_event_threshold_override: i64 = 0,

    /// Specifies how traffic data should be used when calculating routes.
    ///
    /// Default Value: `UseTrafficData`
    ///
    /// Traffic data usage depends on the time parameters in your route request:
    ///
    /// * When `Usage` is set to `UseTrafficData`:
    ///
    /// * If `DepartNow` is set to `true`, or if you specify `DepartureTime` or
    ///   `ArrivalTime`, then all traffic data is considered (including live traffic
    ///   and closures).
    /// * If `DepartNow`, `DepartureTime`, and `ArrivalTime` are all unspecified,
    ///   then only long-term closures are considered, regardless of this setting.
    ///
    /// * When `Usage` is set to `IgnoreTrafficData`, then all traffic data is
    ///   ignored regardless of the time parameters in your route request.
    usage: ?TrafficUsage = null,

    pub const json_field_names = .{
        .flow_event_threshold_override = "FlowEventThresholdOverride",
        .usage = "Usage",
    };
};
