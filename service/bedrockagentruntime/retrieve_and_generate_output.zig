/// Contains the response generated from querying the knowledge base.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `output` field
pub const RetrieveAndGenerateOutput = struct {
    /// The response generated from querying the knowledge base.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
