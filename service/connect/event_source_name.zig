const std = @import("std");

pub const EventSourceName = enum {
    on_post_call_analysis_available,
    on_real_time_call_analysis_available,
    on_real_time_chat_analysis_available,
    on_post_chat_analysis_available,
    on_after_call_work_available,
    on_after_chat_work_available,
    on_email_analysis_available,
    on_zendesk_ticket_create,
    on_zendesk_ticket_status_update,
    on_salesforce_case_create,
    on_contact_evaluation_submit,
    on_metric_data_update,
    on_case_create,
    on_case_update,
    on_sla_breach,
    on_alert_update,
    on_schedule_publish,
    on_schedule_update,
    on_schedule_time_off_request_activity,

    pub const json_field_names = .{
        .on_post_call_analysis_available = "OnPostCallAnalysisAvailable",
        .on_real_time_call_analysis_available = "OnRealTimeCallAnalysisAvailable",
        .on_real_time_chat_analysis_available = "OnRealTimeChatAnalysisAvailable",
        .on_post_chat_analysis_available = "OnPostChatAnalysisAvailable",
        .on_after_call_work_available = "OnAfterCallWorkAvailable",
        .on_after_chat_work_available = "OnAfterChatWorkAvailable",
        .on_email_analysis_available = "OnEmailAnalysisAvailable",
        .on_zendesk_ticket_create = "OnZendeskTicketCreate",
        .on_zendesk_ticket_status_update = "OnZendeskTicketStatusUpdate",
        .on_salesforce_case_create = "OnSalesforceCaseCreate",
        .on_contact_evaluation_submit = "OnContactEvaluationSubmit",
        .on_metric_data_update = "OnMetricDataUpdate",
        .on_case_create = "OnCaseCreate",
        .on_case_update = "OnCaseUpdate",
        .on_sla_breach = "OnSlaBreach",
        .on_alert_update = "OnAlertUpdate",
        .on_schedule_publish = "OnSchedulePublish",
        .on_schedule_update = "OnScheduleUpdate",
        .on_schedule_time_off_request_activity = "OnScheduleTimeOffRequestActivity",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_post_call_analysis_available => "OnPostCallAnalysisAvailable",
            .on_real_time_call_analysis_available => "OnRealTimeCallAnalysisAvailable",
            .on_real_time_chat_analysis_available => "OnRealTimeChatAnalysisAvailable",
            .on_post_chat_analysis_available => "OnPostChatAnalysisAvailable",
            .on_after_call_work_available => "OnAfterCallWorkAvailable",
            .on_after_chat_work_available => "OnAfterChatWorkAvailable",
            .on_email_analysis_available => "OnEmailAnalysisAvailable",
            .on_zendesk_ticket_create => "OnZendeskTicketCreate",
            .on_zendesk_ticket_status_update => "OnZendeskTicketStatusUpdate",
            .on_salesforce_case_create => "OnSalesforceCaseCreate",
            .on_contact_evaluation_submit => "OnContactEvaluationSubmit",
            .on_metric_data_update => "OnMetricDataUpdate",
            .on_case_create => "OnCaseCreate",
            .on_case_update => "OnCaseUpdate",
            .on_sla_breach => "OnSlaBreach",
            .on_alert_update => "OnAlertUpdate",
            .on_schedule_publish => "OnSchedulePublish",
            .on_schedule_update => "OnScheduleUpdate",
            .on_schedule_time_off_request_activity => "OnScheduleTimeOffRequestActivity",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
