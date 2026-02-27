pub const EstimatedCostTier = enum {
    l1,
    l2,
    l3,
    l4,

    pub const json_field_names = .{
        .l1 = "L1",
        .l2 = "L2",
        .l3 = "L3",
        .l4 = "L4",
    };
};
