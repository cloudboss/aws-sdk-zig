const TrafficUsage = @import("traffic_usage.zig").TrafficUsage;

/// Controls how real-time and historical traffic data is used when calculating
/// reachable areas. This affects both the size and shape of isolines by
/// accounting for expected travel speeds based on congestion patterns.
pub const IsolineTrafficOptions = struct {
    /// The duration in seconds that real-time congestion data is considered valid
    /// before reverting to historical traffic patterns. This helps balance between
    /// using current conditions and more predictable historical data when
    /// calculating travel times.
    ///
    /// **Unit**: `seconds`
    flow_event_threshold_override: i64 = 0,

    /// Controls whether traffic data is used in calculations. `UseTrafficData`
    /// considers both real-time congestion and historical patterns, while
    /// `IgnoreTrafficData` calculates routes based solely on road types and speed
    /// limits. Using traffic data provides more accurate real-world estimates but
    /// may produce different results at different times of day.
    ///
    /// Default value: `UseTrafficData`
    usage: ?TrafficUsage = null,

    pub const json_field_names = .{
        .flow_event_threshold_override = "FlowEventThresholdOverride",
        .usage = "Usage",
    };
};
