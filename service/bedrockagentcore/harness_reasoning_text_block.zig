/// A block of reasoning text from the model.
pub const HarnessReasoningTextBlock = struct {
    /// Signature for verifying the reasoning content.
    signature: ?[]const u8 = null,

    /// The reasoning text.
    text: []const u8,

    pub const json_field_names = .{
        .signature = "signature",
        .text = "text",
    };
};
