pub const RangeConstraint = enum {
    contiguous,
    noncontiguous,

    pub const json_field_names = .{
        .contiguous = "CONTIGUOUS",
        .noncontiguous = "NONCONTIGUOUS",
    };
};
