pub const EvaluationQuestionAnswerAnalysisType = enum {
    contact_lens_data,
    gen_ai,

    pub const json_field_names = .{
        .contact_lens_data = "CONTACT_LENS_DATA",
        .gen_ai = "GEN_AI",
    };
};
