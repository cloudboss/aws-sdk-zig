pub const ColumnNullable = enum {
    not_null,
    nullable,
    unknown,

    pub const json_field_names = .{
        .not_null = "NOT_NULL",
        .nullable = "NULLABLE",
        .unknown = "UNKNOWN",
    };
};
