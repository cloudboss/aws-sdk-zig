pub const TaggableResourceType = enum {
    batch_prediction,
    datasource,
    evaluation,
    ml_model,

    pub const json_field_names = .{
        .batch_prediction = "BATCH_PREDICTION",
        .datasource = "DATASOURCE",
        .evaluation = "EVALUATION",
        .ml_model = "ML_MODEL",
    };
};
