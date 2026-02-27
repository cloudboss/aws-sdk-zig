const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;

/// The configuration to set the retention period of an FSx for ONTAP SnapLock
/// volume. The retention
/// period includes default, maximum, and minimum settings. For more
/// information, see
/// [Working with the retention period
/// in
/// SnapLock](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-retention.html).
pub const SnaplockRetentionPeriod = struct {
    /// The retention period assigned to a write once, read many (WORM) file by
    /// default if an explicit retention period is not set for an
    /// FSx for ONTAP SnapLock volume. The default retention period must be greater
    /// than or equal to
    /// the minimum retention period and less than or equal to the maximum retention
    /// period.
    default_retention: RetentionPeriod,

    /// The longest retention period that can be assigned to a WORM file on
    /// an FSx for ONTAP SnapLock volume.
    maximum_retention: RetentionPeriod,

    /// The shortest retention period that can be assigned to a WORM file on an FSx
    /// for ONTAP SnapLock volume.
    minimum_retention: RetentionPeriod,

    pub const json_field_names = .{
        .default_retention = "DefaultRetention",
        .maximum_retention = "MaximumRetention",
        .minimum_retention = "MinimumRetention",
    };
};
