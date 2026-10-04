const std = @import("std");

pub const AnalyticsSessionField = enum {
    conversation_end_state,
    locale_id,

    pub const json_field_names = .{
        .conversation_end_state = "ConversationEndState",
        .locale_id = "LocaleId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conversation_end_state => "ConversationEndState",
            .locale_id => "LocaleId",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
