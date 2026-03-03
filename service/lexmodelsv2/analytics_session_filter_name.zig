const std = @import("std");

pub const AnalyticsSessionFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,
    duration,
    conversation_end_state,
    session_id,
    originating_request_id,
    intent_path,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
        .duration = "Duration",
        .conversation_end_state = "ConversationEndState",
        .session_id = "SessionId",
        .originating_request_id = "OriginatingRequestId",
        .intent_path = "IntentPath",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bot_alias_id => "BotAliasId",
            .bot_version => "BotVersion",
            .locale_id => "LocaleId",
            .modality => "Modality",
            .channel => "Channel",
            .duration => "Duration",
            .conversation_end_state => "ConversationEndState",
            .session_id => "SessionId",
            .originating_request_id => "OriginatingRequestId",
            .intent_path => "IntentPath",
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
