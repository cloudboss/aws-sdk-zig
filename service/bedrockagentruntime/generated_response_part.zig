const TextResponsePart = @import("text_response_part.zig").TextResponsePart;

/// Contains metadata about a part of the generated response that is accompanied
/// by a citation.
///
/// This data type is used in the following API operations:
///
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `generatedResponsePart` field
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `generatedResponsePart` field
pub const GeneratedResponsePart = struct {
    /// Contains metadata about a textual part of the generated response that is
    /// accompanied by a citation.
    text_response_part: ?TextResponsePart = null,

    pub const json_field_names = .{
        .text_response_part = "textResponsePart",
    };
};
