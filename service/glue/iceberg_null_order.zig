pub const IcebergNullOrder = enum {
    nulls_first,
    nulls_last,

    pub const json_field_names = .{
        .nulls_first = "NULLS_FIRST",
        .nulls_last = "NULLS_LAST",
    };
};
