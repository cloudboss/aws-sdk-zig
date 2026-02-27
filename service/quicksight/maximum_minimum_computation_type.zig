pub const MaximumMinimumComputationType = enum {
    maximum,
    minimum,

    pub const json_field_names = .{
        .maximum = "MAXIMUM",
        .minimum = "MINIMUM",
    };
};
