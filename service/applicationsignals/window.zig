const DurationUnit = @import("duration_unit.zig").DurationUnit;

/// The object that defines the time length of an exclusion window.
pub const Window = struct {
    /// The number of time units for the exclusion window length.
    duration: i32,

    /// The unit of time for the exclusion window duration. Valid values: MINUTE,
    /// HOUR, DAY, MONTH.
    duration_unit: DurationUnit,

    pub const json_field_names = .{
        .duration = "Duration",
        .duration_unit = "DurationUnit",
    };
};
