/// The number of characters in the input text to be analyzed.
pub const Characters = struct {
    /// The number of characters present in the input text document as processed by
    /// Amazon Comprehend Medical.
    original_text_characters: ?i32 = null,

    pub const json_field_names = .{
        .original_text_characters = "OriginalTextCharacters",
    };
};
