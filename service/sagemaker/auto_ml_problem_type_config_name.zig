pub const AutoMLProblemTypeConfigName = enum {
    image_classification,
    text_classification,
    timeseries_forecasting,
    tabular,
    text_generation,

    pub const json_field_names = .{
        .image_classification = "IMAGE_CLASSIFICATION",
        .text_classification = "TEXT_CLASSIFICATION",
        .timeseries_forecasting = "TIMESERIES_FORECASTING",
        .tabular = "TABULAR",
        .text_generation = "TEXT_GENERATION",
    };
};
