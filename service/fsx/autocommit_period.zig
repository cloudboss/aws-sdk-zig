const AutocommitPeriodType = @import("autocommit_period_type.zig").AutocommitPeriodType;

/// Sets the autocommit period of files in an FSx for ONTAP SnapLock volume,
/// which determines
/// how long the files must
/// remain unmodified before they're automatically transitioned to the write
/// once, read many (WORM) state.
///
/// For more information, see
/// [Autocommit](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/worm-state.html#worm-state-autocommit).
pub const AutocommitPeriod = struct {
    /// Defines the type of time for the autocommit period of a file in an FSx for
    /// ONTAP SnapLock volume.
    /// Setting this value to `NONE` disables autocommit. The default value is
    /// `NONE`.
    @"type": AutocommitPeriodType,

    /// Defines the amount of time for the autocommit period of a file in an FSx for
    /// ONTAP SnapLock volume.
    /// The following ranges are valid:
    ///
    /// * `Minutes`: 5 - 65,535
    ///
    /// * `Hours`: 1 - 65,535
    ///
    /// * `Days`: 1 - 3,650
    ///
    /// * `Months`: 1 - 120
    ///
    /// * `Years`: 1 - 10
    value: ?i32 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
