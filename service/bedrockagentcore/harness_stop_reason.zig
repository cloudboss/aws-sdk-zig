const std = @import("std");

pub const HarnessStopReason = enum {
    end_turn,
    tool_use,
    tool_result,
    max_tokens,
    stop_sequence,
    content_filtered,
    malformed_model_output,
    malformed_tool_use,
    interrupted,
    partial_turn,
    model_context_window_exceeded,
    max_iterations_exceeded,
    max_output_tokens_exceeded,
    timeout_exceeded,

    pub const json_field_names = .{
        .end_turn = "end_turn",
        .tool_use = "tool_use",
        .tool_result = "tool_result",
        .max_tokens = "max_tokens",
        .stop_sequence = "stop_sequence",
        .content_filtered = "content_filtered",
        .malformed_model_output = "malformed_model_output",
        .malformed_tool_use = "malformed_tool_use",
        .interrupted = "interrupted",
        .partial_turn = "partial_turn",
        .model_context_window_exceeded = "model_context_window_exceeded",
        .max_iterations_exceeded = "max_iterations_exceeded",
        .max_output_tokens_exceeded = "max_output_tokens_exceeded",
        .timeout_exceeded = "timeout_exceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end_turn => "end_turn",
            .tool_use => "tool_use",
            .tool_result => "tool_result",
            .max_tokens => "max_tokens",
            .stop_sequence => "stop_sequence",
            .content_filtered => "content_filtered",
            .malformed_model_output => "malformed_model_output",
            .malformed_tool_use => "malformed_tool_use",
            .interrupted => "interrupted",
            .partial_turn => "partial_turn",
            .model_context_window_exceeded => "model_context_window_exceeded",
            .max_iterations_exceeded => "max_iterations_exceeded",
            .max_output_tokens_exceeded => "max_output_tokens_exceeded",
            .timeout_exceeded => "timeout_exceeded",
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
