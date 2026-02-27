pub const ValidatorType = enum {
    json_schema,
    lambda,

    pub const json_field_names = .{
        .json_schema = "JSON_SCHEMA",
        .lambda = "LAMBDA",
    };
};
