pub const AIPromptType = enum {
    answer_generation,
    intent_labeling_generation,
    query_reformulation,
    self_service_pre_processing,
    self_service_answer_generation,
    email_response,
    email_overview,
    email_generative_answer,
    email_query_reformulation,
    orchestration,
    note_taking,
    case_summarization,

    pub const json_field_names = .{
        .answer_generation = "ANSWER_GENERATION",
        .intent_labeling_generation = "INTENT_LABELING_GENERATION",
        .query_reformulation = "QUERY_REFORMULATION",
        .self_service_pre_processing = "SELF_SERVICE_PRE_PROCESSING",
        .self_service_answer_generation = "SELF_SERVICE_ANSWER_GENERATION",
        .email_response = "EMAIL_RESPONSE",
        .email_overview = "EMAIL_OVERVIEW",
        .email_generative_answer = "EMAIL_GENERATIVE_ANSWER",
        .email_query_reformulation = "EMAIL_QUERY_REFORMULATION",
        .orchestration = "ORCHESTRATION",
        .note_taking = "NOTE_TAKING",
        .case_summarization = "CASE_SUMMARIZATION",
    };
};
