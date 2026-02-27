/// A statistical ranking (percentile) that
/// indicates a threshold value by which a behavior is determined to be in
/// compliance or in
/// violation of the behavior.
pub const StatisticalThreshold = struct {
    /// The percentile that
    /// resolves to a threshold value by which compliance with a behavior is
    /// determined. Metrics are
    /// collected over the specified period (`durationSeconds`) from all reporting
    /// devices
    /// in your account and statistical ranks are calculated. Then, the measurements
    /// from a device are
    /// collected over the same period. If the accumulated measurements from the
    /// device fall above or
    /// below (`comparisonOperator`) the value associated with the percentile
    /// specified,
    /// then the device is considered to be in compliance with the behavior,
    /// otherwise a violation
    /// occurs.
    statistic: ?[]const u8,

    pub const json_field_names = .{
        .statistic = "statistic",
    };
};
