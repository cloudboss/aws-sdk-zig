/// The output content produced by the guardrail.
pub const GuardrailOutputContent = struct {
    /// The specific text for the output content produced by the guardrail.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
