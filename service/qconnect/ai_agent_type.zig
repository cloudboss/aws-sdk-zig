pub const AIAgentType = enum {
    manual_search,
    answer_recommendation,
    self_service,
    email_response,
    email_overview,
    email_generative_answer,
    orchestration,
    note_taking,
    case_summarization,

    pub const json_field_names = .{
        .manual_search = "MANUAL_SEARCH",
        .answer_recommendation = "ANSWER_RECOMMENDATION",
        .self_service = "SELF_SERVICE",
        .email_response = "EMAIL_RESPONSE",
        .email_overview = "EMAIL_OVERVIEW",
        .email_generative_answer = "EMAIL_GENERATIVE_ANSWER",
        .orchestration = "ORCHESTRATION",
        .note_taking = "NOTE_TAKING",
        .case_summarization = "CASE_SUMMARIZATION",
    };
};
