/// The minimum and maximum setup for an axis display range.
pub const AxisDisplayMinMaxRange = struct {
    /// The maximum setup for an axis display range.
    maximum: ?f64 = null,

    /// The minimum setup for an axis display range.
    minimum: ?f64 = null,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
    };
};
