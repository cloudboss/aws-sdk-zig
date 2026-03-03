const std = @import("std");

pub const IntegrationType = enum {
    event,
    voice_id,
    pinpoint_app,
    wisdom_assistant,
    wisdom_knowledge_base,
    wisdom_quick_responses,
    q_message_templates,
    cases_domain,
    application,
    file_scanner,
    ses_identity,
    analytics_connector,
    call_transfer_connector,
    cognito_user_pool,
    message_processor,

    pub const json_field_names = .{
        .event = "EVENT",
        .voice_id = "VOICE_ID",
        .pinpoint_app = "PINPOINT_APP",
        .wisdom_assistant = "WISDOM_ASSISTANT",
        .wisdom_knowledge_base = "WISDOM_KNOWLEDGE_BASE",
        .wisdom_quick_responses = "WISDOM_QUICK_RESPONSES",
        .q_message_templates = "Q_MESSAGE_TEMPLATES",
        .cases_domain = "CASES_DOMAIN",
        .application = "APPLICATION",
        .file_scanner = "FILE_SCANNER",
        .ses_identity = "SES_IDENTITY",
        .analytics_connector = "ANALYTICS_CONNECTOR",
        .call_transfer_connector = "CALL_TRANSFER_CONNECTOR",
        .cognito_user_pool = "COGNITO_USER_POOL",
        .message_processor = "MESSAGE_PROCESSOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event => "EVENT",
            .voice_id => "VOICE_ID",
            .pinpoint_app => "PINPOINT_APP",
            .wisdom_assistant => "WISDOM_ASSISTANT",
            .wisdom_knowledge_base => "WISDOM_KNOWLEDGE_BASE",
            .wisdom_quick_responses => "WISDOM_QUICK_RESPONSES",
            .q_message_templates => "Q_MESSAGE_TEMPLATES",
            .cases_domain => "CASES_DOMAIN",
            .application => "APPLICATION",
            .file_scanner => "FILE_SCANNER",
            .ses_identity => "SES_IDENTITY",
            .analytics_connector => "ANALYTICS_CONNECTOR",
            .call_transfer_connector => "CALL_TRANSFER_CONNECTOR",
            .cognito_user_pool => "COGNITO_USER_POOL",
            .message_processor => "MESSAGE_PROCESSOR",
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
