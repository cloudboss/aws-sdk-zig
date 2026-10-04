const std = @import("std");

pub const AnalyticsBinByName = enum {
    conversation_start_time,
    utterance_timestamp,

    pub const json_field_names = .{
        .conversation_start_time = "ConversationStartTime",
        .utterance_timestamp = "UtteranceTimestamp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conversation_start_time => "ConversationStartTime",
            .utterance_timestamp => "UtteranceTimestamp",
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
