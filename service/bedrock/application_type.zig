pub const ApplicationType = enum {
    model_evaluation,
    rag_evaluation,

    pub const json_field_names = .{
        .model_evaluation = "MODEL_EVALUATION",
        .rag_evaluation = "RAG_EVALUATION",
    };
};
