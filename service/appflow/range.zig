/// The range of values that the property supports.
pub const Range = struct {
    /// Maximum value supported by the field.
    maximum: f64 = 0,

    /// Minimum value supported by the field.
    minimum: f64 = 0,

    pub const json_field_names = .{
        .maximum = "maximum",
        .minimum = "minimum",
    };
};
