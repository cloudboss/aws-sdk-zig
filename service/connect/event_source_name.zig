pub const EventSourceName = enum {
    on_post_call_analysis_available,
    on_real_time_call_analysis_available,
    on_real_time_chat_analysis_available,
    on_post_chat_analysis_available,
    on_zendesk_ticket_create,
    on_zendesk_ticket_status_update,
    on_salesforce_case_create,
    on_contact_evaluation_submit,
    on_metric_data_update,
    on_case_create,
    on_case_update,
    on_sla_breach,

    pub const json_field_names = .{
        .on_post_call_analysis_available = "OnPostCallAnalysisAvailable",
        .on_real_time_call_analysis_available = "OnRealTimeCallAnalysisAvailable",
        .on_real_time_chat_analysis_available = "OnRealTimeChatAnalysisAvailable",
        .on_post_chat_analysis_available = "OnPostChatAnalysisAvailable",
        .on_zendesk_ticket_create = "OnZendeskTicketCreate",
        .on_zendesk_ticket_status_update = "OnZendeskTicketStatusUpdate",
        .on_salesforce_case_create = "OnSalesforceCaseCreate",
        .on_contact_evaluation_submit = "OnContactEvaluationSubmit",
        .on_metric_data_update = "OnMetricDataUpdate",
        .on_case_create = "OnCaseCreate",
        .on_case_update = "OnCaseUpdate",
        .on_sla_breach = "OnSlaBreach",
    };
};
