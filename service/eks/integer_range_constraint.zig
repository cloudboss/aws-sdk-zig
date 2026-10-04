/// An integer range constraint specifying minimum and maximum allowed values.
pub const IntegerRangeConstraint = struct {
    /// The maximum allowed value.
    max: ?i32 = null,

    /// The minimum allowed value.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
