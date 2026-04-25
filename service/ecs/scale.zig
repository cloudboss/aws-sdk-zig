const ScaleUnit = @import("scale_unit.zig").ScaleUnit;

/// A floating-point percentage of the desired number of tasks to place and keep
/// running in the task set.
pub const Scale = struct {
    /// The unit of measure for the scale value.
    unit: ?ScaleUnit = null,

    /// The value, specified as a percent total of a service's `desiredCount`, to
    /// scale the task set. Accepted values are numbers between 0 and 100.
    value: f64 = 0,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
