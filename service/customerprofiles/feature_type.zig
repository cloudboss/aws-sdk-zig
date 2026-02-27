pub const FeatureType = enum {
    textual,
    categorical,

    pub const json_field_names = .{
        .textual = "TEXTUAL",
        .categorical = "CATEGORICAL",
    };
};
