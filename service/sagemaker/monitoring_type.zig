pub const MonitoringType = enum {
    data_quality,
    model_quality,
    model_bias,
    model_explainability,

    pub const json_field_names = .{
        .data_quality = "DATA_QUALITY",
        .model_quality = "MODEL_QUALITY",
        .model_bias = "MODEL_BIAS",
        .model_explainability = "MODEL_EXPLAINABILITY",
    };
};
