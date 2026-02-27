pub const DataSource = enum {
    event,
    model_score,
    external_model_score,

    pub const json_field_names = .{
        .event = "EVENT",
        .model_score = "MODEL_SCORE",
        .external_model_score = "EXTERNAL_MODEL_SCORE",
    };
};
