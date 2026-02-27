/// Contains the query made to the knowledge base.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `input` field
pub const RetrieveAndGenerateInput = struct {
    /// The query made to the knowledge base, in characters.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
