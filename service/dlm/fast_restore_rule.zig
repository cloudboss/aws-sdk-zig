const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// **[Custom snapshot policies only]** Specifies a rule for enabling fast
/// snapshot restore for snapshots created by
/// snapshot policies. You can enable fast snapshot restore based on either a
/// count or a
/// time interval.
pub const FastRestoreRule = struct {
    /// The Availability Zones in which to enable fast snapshot restore.
    availability_zones: []const []const u8,

    /// The number of snapshots to be enabled with fast snapshot restore.
    count: ?i32 = null,

    /// The amount of time to enable fast snapshot restore. The maximum is 100
    /// years. This is
    /// equivalent to 1200 months, 5200 weeks, or 36500 days.
    interval: ?i32 = null,

    /// The unit of time for enabling fast snapshot restore.
    interval_unit: ?RetentionIntervalUnitValues = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .count = "Count",
        .interval = "Interval",
        .interval_unit = "IntervalUnit",
    };
};
