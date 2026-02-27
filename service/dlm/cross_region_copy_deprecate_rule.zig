const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// **[Custom AMI policies only]** Specifies an AMI deprecation rule for
/// cross-Region AMI copies created by an AMI policy.
pub const CrossRegionCopyDeprecateRule = struct {
    /// The period after which to deprecate the cross-Region AMI copies. The period
    /// must be less than or
    /// equal to the cross-Region AMI copy retention period, and it can't be greater
    /// than 10 years. This is
    /// equivalent to 120 months, 520 weeks, or 3650 days.
    interval: ?i32,

    /// The unit of time in which to measure the **Interval**. For example,
    /// to deprecate a cross-Region AMI copy after 3 months, specify `Interval=3`
    /// and
    /// `IntervalUnit=MONTHS`.
    interval_unit: ?RetentionIntervalUnitValues,

    pub const json_field_names = .{
        .interval = "Interval",
        .interval_unit = "IntervalUnit",
    };
};
