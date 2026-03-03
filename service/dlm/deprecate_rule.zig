const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// **[Custom AMI policies only]** Specifies an AMI deprecation rule for AMIs
/// created by an AMI lifecycle policy.
///
/// For age-based schedules, you must specify **Interval** and
/// **IntervalUnit**. For count-based schedules, you must specify
/// **Count**.
pub const DeprecateRule = struct {
    /// If the schedule has a count-based retention rule, this parameter specifies
    /// the number of oldest
    /// AMIs to deprecate. The count must be less than or equal to the schedule's
    /// retention count, and it
    /// can't be greater than 1000.
    count: ?i32 = null,

    /// If the schedule has an age-based retention rule, this parameter specifies
    /// the period after which
    /// to deprecate AMIs created by the schedule. The period must be less than or
    /// equal to the schedule's
    /// retention period, and it can't be greater than 10 years. This is equivalent
    /// to 120 months, 520
    /// weeks, or 3650 days.
    interval: ?i32 = null,

    /// The unit of time in which to measure the **Interval**.
    interval_unit: ?RetentionIntervalUnitValues = null,

    pub const json_field_names = .{
        .count = "Count",
        .interval = "Interval",
        .interval_unit = "IntervalUnit",
    };
};
