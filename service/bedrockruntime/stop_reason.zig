const std = @import("std");

pub const StopReason = enum {
    end_turn,
    tool_use,
    max_tokens,
    stop_sequence,
    guardrail_intervened,
    content_filtered,
    malformed_model_output,
    malformed_tool_use,
    model_context_window_exceeded,

    pub const json_field_names = .{
        .end_turn = "end_turn",
        .tool_use = "tool_use",
        .max_tokens = "max_tokens",
        .stop_sequence = "stop_sequence",
        .guardrail_intervened = "guardrail_intervened",
        .content_filtered = "content_filtered",
        .malformed_model_output = "malformed_model_output",
        .malformed_tool_use = "malformed_tool_use",
        .model_context_window_exceeded = "model_context_window_exceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end_turn => "end_turn",
            .tool_use => "tool_use",
            .max_tokens => "max_tokens",
            .stop_sequence => "stop_sequence",
            .guardrail_intervened => "guardrail_intervened",
            .content_filtered => "content_filtered",
            .malformed_model_output => "malformed_model_output",
            .malformed_tool_use => "malformed_tool_use",
            .model_context_window_exceeded => "model_context_window_exceeded",
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
