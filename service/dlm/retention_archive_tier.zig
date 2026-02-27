const RetentionIntervalUnitValues = @import("retention_interval_unit_values.zig").RetentionIntervalUnitValues;

/// **[Custom snapshot policies only]** Describes the retention rule for
/// archived snapshots. Once the archive
/// retention threshold is met, the snapshots are permanently deleted from the
/// archive tier.
///
/// The archive retention rule must retain snapshots in the archive tier for a
/// minimum
/// of 90 days.
///
/// For **count-based schedules**, you must specify **Count**. For **age-based
/// schedules**, you must specify **Interval** and
/// ** IntervalUnit**.
///
/// For more information about using snapshot archiving, see [Considerations for
/// snapshot lifecycle
/// policies](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-ami-policy.html#dlm-archive).
pub const RetentionArchiveTier = struct {
    /// The maximum number of snapshots to retain in the archive storage tier for
    /// each volume.
    /// The count must ensure that each snapshot remains in the archive tier for at
    /// least
    /// 90 days. For example, if the schedule creates snapshots every 30 days, you
    /// must specify a
    /// count of 3 or more to ensure that each snapshot is archived for at least 90
    /// days.
    count: ?i32,

    /// Specifies the period of time to retain snapshots in the archive tier. After
    /// this period
    /// expires, the snapshot is permanently deleted.
    interval: ?i32,

    /// The unit of time in which to measure the **Interval**. For
    /// example, to retain a snapshots in the archive tier for 6 months, specify
    /// `Interval=6`
    /// and `IntervalUnit=MONTHS`.
    interval_unit: ?RetentionIntervalUnitValues,

    pub const json_field_names = .{
        .count = "Count",
        .interval = "Interval",
        .interval_unit = "IntervalUnit",
    };
};
