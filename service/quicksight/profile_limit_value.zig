const LimitUnit = @import("limit_unit.zig").LimitUnit;

/// A value that defines a resource usage limit, consisting of a maximum value
/// and a unit of measurement.
pub const ProfileLimitValue = struct {
    /// The maximum allowed value for the resource.
    max_value: i64,

    /// The unit of measurement for the limit value.
    unit: LimitUnit,

    pub const json_field_names = .{
        .max_value = "maxValue",
        .unit = "unit",
    };
};
