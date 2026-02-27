pub const CostCategoryStatus = enum {
    processing,
    applied,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .applied = "APPLIED",
    };
};
