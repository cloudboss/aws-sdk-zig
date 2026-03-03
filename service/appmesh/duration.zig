const DurationUnit = @import("duration_unit.zig").DurationUnit;

/// An object that represents a duration of time.
pub const Duration = struct {
    /// A unit of time.
    unit: ?DurationUnit = null,

    /// A number of time units.
    value: ?i64 = null,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
