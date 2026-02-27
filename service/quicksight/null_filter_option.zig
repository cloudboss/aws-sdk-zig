pub const NullFilterOption = enum {
    all_values,
    non_nulls_only,
    nulls_only,

    pub const json_field_names = .{
        .all_values = "ALL_VALUES",
        .non_nulls_only = "NON_NULLS_ONLY",
        .nulls_only = "NULLS_ONLY",
    };
};
