/// Contains information about where the text with a citation begins and ends in
/// the generated output.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `span` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `span` field
pub const Span = struct {
    /// Where the text with a citation ends in the generated output.
    end: ?i32,

    /// Where the text with a citation starts in the generated output.
    start: ?i32,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
