const RetentionPeriodUnit = @import("retention_period_unit.zig").RetentionPeriodUnit;

/// Information about the retention period for which the retention rule is to
/// retain resources.
pub const RetentionPeriod = struct {
    /// The unit of time in which the retention period is measured. Currently, only
    /// `DAYS`
    /// is supported.
    retention_period_unit: RetentionPeriodUnit,

    /// The period value for which the retention rule is to retain resources,
    /// measured in days.
    /// The supported retention periods are:
    ///
    /// * EBS volumes: 1 - 7 days
    ///
    /// * EBS snapshots and EBS-backed AMIs: 1 - 365 days
    retention_period_value: i32,

    pub const json_field_names = .{
        .retention_period_unit = "RetentionPeriodUnit",
        .retention_period_value = "RetentionPeriodValue",
    };
};
