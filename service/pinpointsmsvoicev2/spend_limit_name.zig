const std = @import("std");

pub const SpendLimitName = enum {
    text_message_monthly_spend_limit,
    voice_message_monthly_spend_limit,
    media_message_monthly_spend_limit,
    notify_message_monthly_spend_limit,

    pub const json_field_names = .{
        .text_message_monthly_spend_limit = "TEXT_MESSAGE_MONTHLY_SPEND_LIMIT",
        .voice_message_monthly_spend_limit = "VOICE_MESSAGE_MONTHLY_SPEND_LIMIT",
        .media_message_monthly_spend_limit = "MEDIA_MESSAGE_MONTHLY_SPEND_LIMIT",
        .notify_message_monthly_spend_limit = "NOTIFY_MESSAGE_MONTHLY_SPEND_LIMIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text_message_monthly_spend_limit => "TEXT_MESSAGE_MONTHLY_SPEND_LIMIT",
            .voice_message_monthly_spend_limit => "VOICE_MESSAGE_MONTHLY_SPEND_LIMIT",
            .media_message_monthly_spend_limit => "MEDIA_MESSAGE_MONTHLY_SPEND_LIMIT",
            .notify_message_monthly_spend_limit => "NOTIFY_MESSAGE_MONTHLY_SPEND_LIMIT",
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
