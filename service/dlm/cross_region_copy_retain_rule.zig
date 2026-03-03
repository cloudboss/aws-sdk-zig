const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// Specifies a retention rule for cross-Region snapshot copies created by
/// snapshot or
/// event-based policies, or cross-Region AMI copies created by AMI policies.
/// After the
/// retention period expires, the cross-Region copy is deleted.
pub const CrossRegionCopyRetainRule = struct {
    /// The amount of time to retain a cross-Region snapshot or AMI copy. The
    /// maximum is 100 years.
    /// This is equivalent to 1200 months, 5200 weeks, or 36500 days.
    interval: ?i32 = null,

    /// The unit of time for time-based retention. For example, to retain a
    /// cross-Region copy for
    /// 3 months, specify `Interval=3` and `IntervalUnit=MONTHS`.
    interval_unit: ?RetentionIntervalUnitValues = null,

    pub const json_field_names = .{
        .interval = "Interval",
        .interval_unit = "IntervalUnit",
    };
};
