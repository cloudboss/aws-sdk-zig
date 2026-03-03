const GuardrailContentQualifier = @import("guardrail_content_qualifier.zig").GuardrailContentQualifier;

/// The text block to be evaluated by the guardrail.
pub const GuardrailTextBlock = struct {
    /// The qualifiers describing the text block.
    qualifiers: ?[]const GuardrailContentQualifier = null,

    /// The input text details to be evaluated by the guardrail.
    text: []const u8,

    pub const json_field_names = .{
        .qualifiers = "qualifiers",
        .text = "text",
    };
};
