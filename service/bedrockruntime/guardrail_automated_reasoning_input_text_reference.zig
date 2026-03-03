/// References a portion of the original input text that corresponds to logical
/// elements.
pub const GuardrailAutomatedReasoningInputTextReference = struct {
    /// The specific text from the original input that this reference points to.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
