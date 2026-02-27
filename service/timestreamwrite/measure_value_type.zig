pub const MeasureValueType = enum {
    double,
    bigint,
    varchar,
    boolean,
    timestamp,
    multi,

    pub const json_field_names = .{
        .double = "DOUBLE",
        .bigint = "BIGINT",
        .varchar = "VARCHAR",
        .boolean = "BOOLEAN",
        .timestamp = "TIMESTAMP",
        .multi = "MULTI",
    };
};
