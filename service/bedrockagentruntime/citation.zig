const GeneratedResponsePart = @import("generated_response_part.zig").GeneratedResponsePart;
const RetrievedReference = @import("retrieved_reference.zig").RetrievedReference;

/// An object containing a segment of the generated response that is based on a
/// source in the knowledge base, alongside information about the source.
///
/// This data type is used in the following API operations:
///
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `citations` field
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `citations` field
pub const Citation = struct {
    /// Contains the generated response and metadata
    generated_response_part: ?GeneratedResponsePart,

    /// Contains metadata about the sources cited for the generated response.
    retrieved_references: ?[]const RetrievedReference,

    pub const json_field_names = .{
        .generated_response_part = "generatedResponsePart",
        .retrieved_references = "retrievedReferences",
    };
};
