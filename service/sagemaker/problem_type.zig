pub const ProblemType = enum {
    binary_classification,
    multiclass_classification,
    regression,

    pub const json_field_names = .{
        .binary_classification = "BINARY_CLASSIFICATION",
        .multiclass_classification = "MULTICLASS_CLASSIFICATION",
        .regression = "REGRESSION",
    };
};
