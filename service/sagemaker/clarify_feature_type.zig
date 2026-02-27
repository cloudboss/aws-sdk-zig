pub const ClarifyFeatureType = enum {
    numerical,
    categorical,
    text,

    pub const json_field_names = .{
        .numerical = "NUMERICAL",
        .categorical = "CATEGORICAL",
        .text = "TEXT",
    };
};
