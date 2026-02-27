/// Instructions for interpreting the contents of a document.
pub const ParsingPrompt = struct {
    /// Instructions for interpreting the contents of a document.
    parsing_prompt_text: []const u8,

    pub const json_field_names = .{
        .parsing_prompt_text = "parsingPromptText",
    };
};
