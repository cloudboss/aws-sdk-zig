const RetentionPeriodType = @import("retention_period_type.zig").RetentionPeriodType;

/// Specifies the retention period of an FSx for ONTAP SnapLock volume. After it
/// is set, it can't be changed.
/// Files can't be
/// deleted or modified during the retention period.
///
/// For more information, see
/// [Working with the retention
/// period in
/// SnapLock](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-retention.html).
pub const RetentionPeriod = struct {
    /// Defines the type of time for the retention period of an FSx for ONTAP
    /// SnapLock volume.
    /// Set it to
    /// one of the valid types. If you set it to `INFINITE`, the files are retained
    /// forever. If you set it to
    /// `UNSPECIFIED`, the files are retained until you set an explicit retention
    /// period.
    @"type": RetentionPeriodType,

    /// Defines the amount of time for the retention period of an FSx for ONTAP
    /// SnapLock volume.
    /// You can't set a value for `INFINITE` or `UNSPECIFIED`. For all other
    /// options, the
    /// following ranges are valid:
    ///
    /// * `Seconds`: 0 - 65,535
    ///
    /// * `Minutes`: 0 - 65,535
    ///
    /// * `Hours`: 0 - 24
    ///
    /// * `Days`: 0 - 365
    ///
    /// * `Months`: 0 - 12
    ///
    /// * `Years`: 0 - 100
    value: ?i32 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
