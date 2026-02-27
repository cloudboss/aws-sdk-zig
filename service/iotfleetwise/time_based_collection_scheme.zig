/// Information about a collection scheme that uses a time period to decide how
/// often to
/// collect data.
pub const TimeBasedCollectionScheme = struct {
    /// The time period (in milliseconds) to decide how often to collect data. For
    /// example, if
    /// the time period is `60000`, the Edge Agent software collects data once every
    /// minute.
    period_ms: i64,

    pub const json_field_names = .{
        .period_ms = "periodMs",
    };
};
