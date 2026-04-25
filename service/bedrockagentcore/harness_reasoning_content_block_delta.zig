/// A delta update to a reasoning content block.
pub const HarnessReasoningContentBlockDelta = union(enum) {
    /// Redacted reasoning content.
    redacted_content: ?[]const u8,
    /// Signature for the reasoning content.
    signature: ?[]const u8,
    /// Reasoning text delta.
    text: ?[]const u8,

    pub const json_field_names = .{
        .redacted_content = "redactedContent",
        .signature = "signature",
        .text = "text",
    };
};
