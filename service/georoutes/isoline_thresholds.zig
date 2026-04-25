/// Specifies the time or distance limits used to calculate reachable areas. You
/// can provide up to five thresholds for a single type to generate multiple
/// isolines in a single request. For example, you might request areas reachable
/// within 5, 10, and 15 minutes, or within 1, 2, and 5 kilometers.
pub const IsolineThresholds = struct {
    /// List of travel distances in meters. For example, [1000, 2000, 5000] would
    /// calculate areas reachable within 1, 2, and 5 kilometers.
    distance: ?[]const i64 = null,

    /// List of travel times in seconds. For example, [300, 600, 900] would
    /// calculate areas reachable within 5, 10, and 15 minutes.
    time: ?[]const i64 = null,

    pub const json_field_names = .{
        .distance = "Distance",
        .time = "Time",
    };
};
