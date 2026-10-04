const std = @import("std");

pub const AnalyticsUtteranceField = enum {
    utterance_text,
    utterance_state,

    pub const json_field_names = .{
        .utterance_text = "UtteranceText",
        .utterance_state = "UtteranceState",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .utterance_text => "UtteranceText",
            .utterance_state => "UtteranceState",
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
