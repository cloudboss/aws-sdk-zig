const Span = @import("span.zig").Span;

/// Contains the part of the generated text that contains a citation, alongside
/// where it begins and ends.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `textResponsePart` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `textResponsePart` field
pub const TextResponsePart = struct {
    /// Contains information about where the text with a citation begins and ends in
    /// the generated output.
    span: ?Span = null,

    /// The part of the generated text that contains a citation.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .span = "span",
        .text = "text",
    };
};
