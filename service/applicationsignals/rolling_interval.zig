const DurationUnit = @import("duration_unit.zig").DurationUnit;

/// If the interval for this SLO is a rolling interval, this structure contains
/// the interval specifications.
pub const RollingInterval = struct {
    /// Specifies the duration of each rolling interval. For example, if `Duration`
    /// is `7` and `DurationUnit` is `DAY`, each rolling interval is seven days.
    duration: i32,

    /// Specifies the rolling interval unit.
    duration_unit: DurationUnit,

    pub const json_field_names = .{
        .duration = "Duration",
        .duration_unit = "DurationUnit",
    };
};
