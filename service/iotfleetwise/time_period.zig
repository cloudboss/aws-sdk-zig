const TimeUnit = @import("time_unit.zig").TimeUnit;

/// The length of time between state template updates.
pub const TimePeriod = struct {
    /// A unit of time.
    unit: TimeUnit,

    /// A number of time units.
    value: i32,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
