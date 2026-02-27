pub const FilterRequirement = enum {
    meets_all,
    meets_any,

    pub const json_field_names = .{
        .meets_all = "MEETS_ALL",
        .meets_any = "MEETS_ANY",
    };
};
