pub const PromptType = enum {
    pre_processing,
    orchestration,
    knowledge_base_response_generation,
    post_processing,
    routing_classifier,

    pub const json_field_names = .{
        .pre_processing = "PRE_PROCESSING",
        .orchestration = "ORCHESTRATION",
        .knowledge_base_response_generation = "KNOWLEDGE_BASE_RESPONSE_GENERATION",
        .post_processing = "POST_PROCESSING",
        .routing_classifier = "ROUTING_CLASSIFIER",
    };
};
