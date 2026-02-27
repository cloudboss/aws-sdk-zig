pub const EvaluationType = enum {
    llmaj_evaluation,
    custom_scorer_evaluation,
    benchmark_evaluation,

    pub const json_field_names = .{
        .llmaj_evaluation = "LLMAJ_EVALUATION",
        .custom_scorer_evaluation = "CUSTOM_SCORER_EVALUATION",
        .benchmark_evaluation = "BENCHMARK_EVALUATION",
    };
};
