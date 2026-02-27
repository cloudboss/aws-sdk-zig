pub const ParameterType = enum {
    integer,
    continuous,
    categorical,
    free_text,

    pub const json_field_names = .{
        .integer = "INTEGER",
        .continuous = "CONTINUOUS",
        .categorical = "CATEGORICAL",
        .free_text = "FREE_TEXT",
    };
};
