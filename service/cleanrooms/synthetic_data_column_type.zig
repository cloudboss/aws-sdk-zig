pub const SyntheticDataColumnType = enum {
    categorical,
    numerical,

    pub const json_field_names = .{
        .categorical = "CATEGORICAL",
        .numerical = "NUMERICAL",
    };
};
