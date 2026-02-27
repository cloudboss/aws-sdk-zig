pub const FilterNullOption = enum {
    all_values,
    nulls_only,
    non_nulls_only,

    pub const json_field_names = .{
        .all_values = "ALL_VALUES",
        .nulls_only = "NULLS_ONLY",
        .non_nulls_only = "NON_NULLS_ONLY",
    };
};
