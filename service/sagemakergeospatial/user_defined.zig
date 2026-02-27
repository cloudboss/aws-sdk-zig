const Unit = @import("unit.zig").Unit;

/// The output resolution (in target georeferenced units)
/// of the result of the operation
pub const UserDefined = struct {
    /// The units for output resolution of the result.
    unit: Unit,

    /// The value for output resolution of the result.
    value: f32,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
