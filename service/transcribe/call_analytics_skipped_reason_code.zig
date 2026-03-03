const std = @import("std");

pub const CallAnalyticsSkippedReasonCode = enum {
    insufficient_conversation_content,
    failed_safety_guidelines,

    pub const json_field_names = .{
        .insufficient_conversation_content = "INSUFFICIENT_CONVERSATION_CONTENT",
        .failed_safety_guidelines = "FAILED_SAFETY_GUIDELINES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_conversation_content => "INSUFFICIENT_CONVERSATION_CONTENT",
            .failed_safety_guidelines => "FAILED_SAFETY_GUIDELINES",
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
