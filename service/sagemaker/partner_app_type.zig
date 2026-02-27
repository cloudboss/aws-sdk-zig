pub const PartnerAppType = enum {
    lakera_guard,
    comet,
    deepchecks_llm_evaluation,
    fiddler,

    pub const json_field_names = .{
        .lakera_guard = "LAKERA_GUARD",
        .comet = "COMET",
        .deepchecks_llm_evaluation = "DEEPCHECKS_LLM_EVALUATION",
        .fiddler = "FIDDLER",
    };
};
