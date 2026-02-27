pub const FilterValueType = enum {
    columnextracted,
    constant,

    pub const json_field_names = .{
        .columnextracted = "COLUMNEXTRACTED",
        .constant = "CONSTANT",
    };
};
