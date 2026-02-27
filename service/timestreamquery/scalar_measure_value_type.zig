pub const ScalarMeasureValueType = enum {
    bigint,
    boolean,
    double,
    varchar,
    timestamp,

    pub const json_field_names = .{
        .bigint = "BIGINT",
        .boolean = "BOOLEAN",
        .double = "DOUBLE",
        .varchar = "VARCHAR",
        .timestamp = "TIMESTAMP",
    };
};
