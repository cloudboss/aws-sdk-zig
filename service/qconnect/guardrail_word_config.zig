/// A word to configure for the AI Guardrail.
pub const GuardrailWordConfig = struct {
    /// Text of the word configured for the AI Guardrail to block.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
