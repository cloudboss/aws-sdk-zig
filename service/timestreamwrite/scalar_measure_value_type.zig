pub const ScalarMeasureValueType = enum {
    double,
    bigint,
    boolean,
    varchar,
    timestamp,

    pub const json_field_names = .{
        .double = "DOUBLE",
        .bigint = "BIGINT",
        .boolean = "BOOLEAN",
        .varchar = "VARCHAR",
        .timestamp = "TIMESTAMP",
    };
};
