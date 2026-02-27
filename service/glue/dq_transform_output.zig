pub const DQTransformOutput = enum {
    primary_input,
    evaluation_results,

    pub const json_field_names = .{
        .primary_input = "PrimaryInput",
        .evaluation_results = "EvaluationResults",
    };
};
