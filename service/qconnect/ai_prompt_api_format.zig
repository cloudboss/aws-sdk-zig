const std = @import("std");

pub const AIPromptAPIFormat = enum {
    anthropic_claude_messages,
    anthropic_claude_text_completions,
    messages,
    text_completions,

    pub const json_field_names = .{
        .anthropic_claude_messages = "ANTHROPIC_CLAUDE_MESSAGES",
        .anthropic_claude_text_completions = "ANTHROPIC_CLAUDE_TEXT_COMPLETIONS",
        .messages = "MESSAGES",
        .text_completions = "TEXT_COMPLETIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .anthropic_claude_messages => "ANTHROPIC_CLAUDE_MESSAGES",
            .anthropic_claude_text_completions => "ANTHROPIC_CLAUDE_TEXT_COMPLETIONS",
            .messages => "MESSAGES",
            .text_completions => "TEXT_COMPLETIONS",
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
