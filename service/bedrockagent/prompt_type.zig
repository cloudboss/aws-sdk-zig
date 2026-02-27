pub const PromptType = enum {
    pre_processing,
    orchestration,
    post_processing,
    knowledge_base_response_generation,
    memory_summarization,

    pub const json_field_names = .{
        .pre_processing = "PRE_PROCESSING",
        .orchestration = "ORCHESTRATION",
        .post_processing = "POST_PROCESSING",
        .knowledge_base_response_generation = "KNOWLEDGE_BASE_RESPONSE_GENERATION",
        .memory_summarization = "MEMORY_SUMMARIZATION",
    };
};
