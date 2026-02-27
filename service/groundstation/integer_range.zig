/// An integer range that has a minimum and maximum value.
pub const IntegerRange = struct {
    /// A maximum value.
    maximum: i32,

    /// A minimum value.
    minimum: i32,

    pub const json_field_names = .{
        .maximum = "maximum",
        .minimum = "minimum",
    };
};
