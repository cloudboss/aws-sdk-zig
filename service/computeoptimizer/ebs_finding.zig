pub const EBSFinding = enum {
    optimized,
    not_optimized,

    pub const json_field_names = .{
        .optimized = "OPTIMIZED",
        .not_optimized = "NOT_OPTIMIZED",
    };
};
