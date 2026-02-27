pub const MeasureValueType = enum {
    bigint,
    boolean,
    double,
    varchar,
    multi,

    pub const json_field_names = .{
        .bigint = "BIGINT",
        .boolean = "BOOLEAN",
        .double = "DOUBLE",
        .varchar = "VARCHAR",
        .multi = "MULTI",
    };
};
