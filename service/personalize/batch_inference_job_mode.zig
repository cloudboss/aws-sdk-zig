pub const BatchInferenceJobMode = enum {
    batch_inference,
    theme_generation,

    pub const json_field_names = .{
        .batch_inference = "BATCH_INFERENCE",
        .theme_generation = "THEME_GENERATION",
    };
};
