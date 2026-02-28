pub const FilterName = enum {
    feature,
    severity,
    type,

    pub const json_field_names = .{
        .feature = "FEATURE",
        .severity = "SEVERITY",
        .type = "TYPE",
    };
};
