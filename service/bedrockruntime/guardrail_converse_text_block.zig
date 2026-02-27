const GuardrailConverseContentQualifier = @import("guardrail_converse_content_qualifier.zig").GuardrailConverseContentQualifier;

/// A text block that contains text that you want to assess with a guardrail.
/// For more information, see
/// [GuardrailConverseContentBlock](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_GuardrailConverseContentBlock.html).
pub const GuardrailConverseTextBlock = struct {
    /// The qualifier details for the guardrails contextual grounding filter.
    qualifiers: ?[]const GuardrailConverseContentQualifier,

    /// The text that you want to guard.
    text: []const u8,

    pub const json_field_names = .{
        .qualifiers = "qualifiers",
        .text = "text",
    };
};
