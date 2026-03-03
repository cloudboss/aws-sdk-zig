/// An object used to store information about the Type detected by Amazon
/// Textract.
pub const ExpenseType = struct {
    /// The confidence of accuracy, as a percentage.
    confidence: ?f32 = null,

    /// The word or line of text detected by Amazon Textract.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .text = "Text",
    };
};
