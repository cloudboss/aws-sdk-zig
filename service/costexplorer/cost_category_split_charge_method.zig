pub const CostCategorySplitChargeMethod = enum {
    fixed,
    proportional,
    even,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .proportional = "PROPORTIONAL",
        .even = "EVEN",
    };
};
