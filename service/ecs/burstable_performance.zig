pub const BurstablePerformance = enum {
    included,
    required,
    excluded,

    pub const json_field_names = .{
        .included = "INCLUDED",
        .required = "REQUIRED",
        .excluded = "EXCLUDED",
    };
};
