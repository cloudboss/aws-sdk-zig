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
        .end_turn = "END_TURN",
        .tool_use = "TOOL_USE",
        .max_tokens = "MAX_TOKENS",
        .stop_sequence = "STOP_SEQUENCE",
        .guardrail_intervened = "GUARDRAIL_INTERVENED",
        .content_filtered = "CONTENT_FILTERED",
        .malformed_model_output = "MALFORMED_MODEL_OUTPUT",
        .malformed_tool_use = "MALFORMED_TOOL_USE",
        .model_context_window_exceeded = "MODEL_CONTEXT_WINDOW_EXCEEDED",
    };
};
